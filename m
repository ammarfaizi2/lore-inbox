Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTJIWtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTJIWtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:49:05 -0400
Received: from [66.212.224.118] ([66.212.224.118]:17169 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262564AbTJIWtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:49:03 -0400
Date: Thu, 9 Oct 2003 18:48:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Cherry <cherry@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] IA32 (2.6.0-test7 - 2003-10-08.18.30) - 1 New warnings
 (gcc 3.2.2)
In-Reply-To: <200310090627.h996RVN0021822@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0310091837330.3679@montezuma.fsmlabs.com>
References: <200310090627.h996RVN0021822@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, John Cherry wrote:

> drivers/atm/fore200e.c:1074: warning: unused variable `i'

Index: linux-2.6.0-test7/drivers/atm/fore200e.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7/drivers/atm/fore200e.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fore200e.c
--- linux-2.6.0-test7/drivers/atm/fore200e.c	9 Oct 2003 05:55:44 -0000	1.1.1.1
+++ linux-2.6.0-test7/drivers/atm/fore200e.c	9 Oct 2003 22:37:05 -0000
@@ -1071,7 +1071,6 @@ fore200e_find_vcc(struct fore200e* fore2
     struct sock *s;
     struct atm_vcc* vcc;
     struct hlist_node *node;
-    int i;
 
     read_lock(&vcc_sklist_lock);
 
