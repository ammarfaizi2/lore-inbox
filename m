Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbTCYR3g>; Tue, 25 Mar 2003 12:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263131AbTCYR2f>; Tue, 25 Mar 2003 12:28:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63611 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263107AbTCYR2a>; Tue, 25 Mar 2003 12:28:30 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdepO006897@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/8] 2.4: Fix duplicate #include in journal.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4-ext3push/fs/jbd/journal.c.=K0002=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/fs/jbd/journal.c	2003-03-25 10:59:15.000000000 +0000
@@ -33,7 +33,6 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/slab.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
