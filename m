Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268513AbTGISOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268512AbTGISOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:14:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268517AbTGISNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:13:11 -0400
Date: Wed, 9 Jul 2003 11:25:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] make profile= doc. clearer
Message-Id: <20030709112559.3c450894.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply to 2.4.22-pre.


patch_name:	kernproftext_24.patch
patch_version:	2003-07-09.11:14:56
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make profile=<number> clearer
product:	Linux
product_versions: 2.4.22-pre
diffstat:	=
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./Documentation/kernel-parameters.txt~prof ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~prof	2003-06-24 14:07:22.000000000 -0700
+++ ./Documentation/kernel-parameters.txt	2003-07-09 10:14:14.000000000 -0700
@@ -503,7 +503,7 @@
 	plip=		[PPT,NET] Parallel port network link.
 
 	profile=	[KNL] enable kernel profiling via /proc/profile
-			(param:log level).
+			(param: profile step/bucket size as a power of 2)
 
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.

Thanks.
--
~Randy
