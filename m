Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268528AbTGISM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbTGISM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:12:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268517AbTGISMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:12:42 -0400
Date: Wed, 9 Jul 2003 11:25:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] make profile= doc. clearer
Message-Id: <20030709112550.30960a25.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please apply to 2.5.current.
Change profile sampling step description from <log_level>
to better wording.


patch_name:	kernproftext_25.patch
patch_version:	2003-07-09.11:11:47
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make profile=<number> clearer
product:	Linux
product_versions: 2.5.74
diffstat:	=
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./Documentation/kernel-parameters.txt~prof ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~prof	2003-07-02 13:58:26.000000000 -0700
+++ ./Documentation/kernel-parameters.txt	2003-07-09 10:22:11.000000000 -0700
@@ -772,7 +772,7 @@
 			Ranges are in pairs (memory base and size).
 
 	profile=	[KNL] Enable kernel profiling via /proc/profile
-			Format: <log_level>
+			(param: profile step/bucket size as a power of 2)
 
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.


Thanks,
--
~Randy
