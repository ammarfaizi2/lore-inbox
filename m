Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVG2KmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVG2KmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVG2KmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:42:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:41896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262563AbVG2KmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:42:11 -0400
Date: Fri, 29 Jul 2005 12:42:08 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       akpm@osdl.org, chrisw@osdl.org
MIME-Version: 1.0
References: <20050729083850.GB7302@elte.hu>
Subject: =?ISO-8859-1?Q?Re:_Broke_nice_range_for_RLIMIT_NICE?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <5482.1122633728@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The other downside is, this obviously changes any existing configs 
> > actually using this by one nice level..
> 
> it's pretty harmless, and i doubt the use of this is all that wide (if 
> existent at all - utilities have not been updated yet). Lets fix it 
> ASAP, preferably in 2.6.13.

Yes, as noted in my earlier message -- at the moment RLIMIT_NICE 
still isn't in the current glibc snapshot...

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
