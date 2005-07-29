Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVG2LdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVG2LdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVG2Laq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:30:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:42624 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262506AbVG2L3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:29:30 -0400
Date: Fri, 29 Jul 2005 13:29:29 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net, torvalds@osdl.org
MIME-Version: 1.0
References: <20050728104316.02c7aba5.akpm@osdl.org>
Subject: =?ISO-8859-1?Q?[PATCH]_MAINTAINERS_record_--_MAN-PAGES?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <12914.1122636569@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

[Was: Re: Broke nice range for RLIMIT NICE]

> > (A passing note to all kernel developers: when 
> >  making changes that affect userland-kernel interfaces, please 
> >  send me a man-pages patch, or at least a notification of the 
> >  change, so that some information makes its way into the manual 
> >  pages).
> 
> Could I suggest that you send in a MAINTANERS record?  That might help a
> bit.

Thanks for the idea.  Hopefully the following (against the
2.6.12 MAINTAINERS file) suffices...

Cheers,

Michael

--- MAINTAINERS 2005-06-20 14:37:59.000000000 +0200
+++ MAINTAINERS.new     2005-07-29 13:34:46.000000000 +0200
@@ -1478,6 +1478,12 @@
 M:     zab@zabbo.net
 S:     Odd Fixes

+MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
+P: Michael Kerrisk
+M: mtk-manpages@gmx.net
+W: ftp://ftp.kernel.org/pub/linux/docs/manpages
+S: Maintained
+
 MARVELL MV64340 ETHERNET DRIVER
 P:     Manish Lachwani
 M:     Manish_Lachwani@pmc-sierra.com

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
