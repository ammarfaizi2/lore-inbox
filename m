Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273078AbTG3RZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273079AbTG3RZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:25:40 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:20193 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S273078AbTG3RZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:25:32 -0400
Message-Id: <200307301713.h6UHDFsG012606@ginger.cmf.nrl.navy.mil>
To: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <eguaj@free.fr>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Reply-To: chas3@users.sourceforge.net
Subject: Re: [PATCH] fix 2.6.0-test1 *** Warning: "llc_oui" [net/sched/sch_atm.ko] undefined! 
In-reply-to: Your message of "Fri, 25 Jul 2003 12:31:07 +0200."
             <20030725103106.GB1670@satellite.workgroup.fr> 
Date: Wed, 30 Jul 2003 13:10:32 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please apply to 2.6 -- thanks

In message <20030725103106.GB1670@satellite.workgroup.fr>,=?iso-8859-15?B?Suly9
G1lIEF1Z+k=?= writes:
>Fix a typo in 'net/atm/Makefile' that gives a 'Warning: "llc_oui"
>[net/sched/sch_atm.ko] undefined!' when building modules:


[atm]: fix a typo in net/atm/Makefile (from eguaj@free.fr)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1599  -> 1.1600 
#	    net/atm/Makefile	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/30	chas@relax.cmf.nrl.navy.mil	1.1600
# fix a typo in net/atm/Makefile (from eguaj@free.fr)
# --------------------------------------------
#
diff -Nru a/net/atm/Makefile b/net/atm/Makefile
--- a/net/atm/Makefile	Wed Jul 30 13:12:21 2003
+++ b/net/atm/Makefile	Wed Jul 30 13:12:21 2003
@@ -10,7 +10,7 @@
 atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
 atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
-atm-$(subst m,y,$CONFIG_NET_SCH_ATM)) += ipcommon.o
+atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
 atm-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o
