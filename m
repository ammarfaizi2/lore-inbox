Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWFRQ60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWFRQ60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWFRQ60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:58:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35518 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932253AbWFRQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:58:26 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 18:57:58 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 1/6] ieee1394: nodemgr: remove unnecessary
 includes
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
Message-ID: <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.045) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 08:57:09.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 09:11:18.000000000 +0200
@@ -12,12 +12,8 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/pci.h>
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 


