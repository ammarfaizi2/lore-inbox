Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTIVSA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbTIVSA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:00:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:39584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261642AbTIVSAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:00:55 -0400
Date: Mon, 22 Sep 2003 10:53:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ikconfig: remove unneeded include files
Message-Id: <20030922105357.0c84657c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please merge this small patch.

--
~Randy


patch_name:	includes_rm.patch
patch_version:	2003-09-22.11:02:58
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove 2 unneeded header files, so that configs.o
		isn't rebuilt on every 'make bzImage';
product:	Linux
product_versions: 2.6.0-922
maintainer:	Randy.Dunlap <rddunlap@osdl.org>
diffstat:	=
 kernel/configs.c |    2 --
 1 files changed, 2 deletions(-)


diff -Naurp ./kernel/configs.c~includes ./kernel/configs.c
--- ./kernel/configs.c~includes	2003-09-22 08:45:15.000000000 -0700
+++ ./kernel/configs.c	2003-09-22 11:00:40.000000000 -0700
@@ -29,8 +29,6 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
-#include <linux/compile.h>
-#include <linux/version.h>
 #include <asm/uaccess.h>
 
 /**************************************************/
