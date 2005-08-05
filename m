Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVHEUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVHEUNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVHEULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:11:42 -0400
Received: from pop.gmx.net ([213.165.64.20]:1985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263066AbVHEUIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:08:48 -0400
X-Authenticated: #2864774
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Ulrich Drepper <drepper@redhat.com>
Date: Fri, 05 Aug 2005 22:08:23 +0200
MIME-Version: 1.0
Subject: Re: pselect() modifying timeout
CC: David Woodhouse <dwmw2@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org, bert.hubert@netherlabs.nl, akpm@osdl.org,
       mtk-lkml@gmx.net
Message-ID: <42F3E357.3257.1BD78615@localhost>
In-reply-to: <42F37CC5.6030206@redhat.com>
References: <31556.1123238544@www44.gmx.net>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Michael Kerrisk wrote:
> > Please consider making Linux pselect() conform to POSIX on this 
> > point.
> 
> There is no question the implementation will conform.  But this not
> dependent on changing the syscall interface.  We deliberately decided to
> not require the kernel interface to be different from select.  The
> userlevel code will take care of the difference.  The kernel code is good
> as proposed.

Okay -- thanks for the info.

Cheers,

Michael



