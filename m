Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUK0CG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUK0CG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbUK0CG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:06:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261223AbUKZTiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:11 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] - Externel SLIT table information thru sysfs
References: <34a45-4B7-9@gated-at.bofh.it> <34hyB-2nd-21@gated-at.bofh.it>
	<34iNY-3nm-27@gated-at.bofh.it>
From: Andi Kleen <ak@suse.de>
Date: 25 Nov 2004 12:12:04 +0100
In-Reply-To: <34iNY-3nm-27@gated-at.bofh.it>
Message-ID: <p73r7miuqrf.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> > >        10 20 64 42 42 22
> 
> Care to turn this into a one value per file implementation instead of
> this?  That will make it easier to determine exactly what the data in
> each file is, and follow the sysfs rules.

No, we discussed this already earlier (please check the thread)

One file for each would lead to excessive memory consumption on large
systems, and it would make it much more costly for programs to read
this information.

Also the sysfs documentation allows for this case where it makes
sense even.

-Andi
