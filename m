Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUK1XNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUK1XNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUK1XNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:13:45 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:59628 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261386AbUK1XNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:13:44 -0500
To: A M <alim1993@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing a process structure in the processes link list
References: <20041128225720.99389.qmail@web51909.mail.yahoo.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Sun, 28 Nov 2004 18:13:42 -0500
In-Reply-To: <20041128225720.99389.qmail@web51909.mail.yahoo.com> (A. M.'s
 message of "Sun, 28 Nov 2004 14:57:20 -0800 (PST)")
Message-ID: <874qj9lg7t.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A M <alim1993@yahoo.com> writes:

> Would it be possible for a program running as root
> that wasn't compiled with the kernel to access a
> process structure in the processes link list? 

Yes, but see below.

> I've read an article about hiding processes and the
> article made sound so easy to access the link list and
> hide a process, how easy is it?

You need read access to /dev/kmem and a fairly intimate knowledge of
the kernel data structures in question.
 
> Is it possible to a process to access its own entry in
> the processes link list?

Not without read access to the kmem device...

-Doug
