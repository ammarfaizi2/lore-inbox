Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSFSOv4>; Wed, 19 Jun 2002 10:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSFSOv4>; Wed, 19 Jun 2002 10:51:56 -0400
Received: from pcp748332pcs.manass01.va.comcast.net ([68.49.120.123]:51915
	"EHLO pcp748332pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S317896AbSFSOvy>; Wed, 19 Jun 2002 10:51:54 -0400
Date: Wed, 19 Jun 2002 10:51:50 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.23 tqueue patches
Message-ID: <20020619145150.GA4872@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.56
Reply-To: Matthew Harrell 
	  <mharrell-dated-1024930311.21b73e@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Just patches where tqueue.h was missing

-- 
  Matthew Harrell                          I don't suffer from insanity - 
  Bit Twiddlers, Inc.                       I enjoy every minute of it.
  mharrell@bittwiddlers.com     

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tqueue.patch"

--- linux/fs/smbfs/sock.c-ori	Wed Jun 19 09:52:33 2002
+++ linux/fs/smbfs/sock.c	Wed Jun 19 09:52:53 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>
 
--- linux/drivers/pcmcia/i82365.c.ori	Wed Jun 19 10:23:07 2002
+++ linux/drivers/pcmcia/i82365.c	Wed Jun 19 10:21:58 2002
@@ -46,6 +46,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
--- linux/drivers/usb/net/usbnet.c.ori	Wed Jun 19 10:27:35 2002
+++ linux/drivers/usb/net/usbnet.c	Wed Jun 19 10:27:50 2002
@@ -116,6 +116,7 @@
 #include <linux/etherdevice.h>
 #include <linux/random.h>
 #include <linux/ethtool.h>
+#include <linux/tqueue.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
--- linux/net/irda/ircomm/ircomm_param.c.ori	Wed Jun 19 10:44:51 2002
+++ linux/net/irda/ircomm/ircomm_param.c	Wed Jun 19 10:46:38 2002
@@ -29,6 +29,7 @@
  ********************************************************************/
 
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 
 #include <net/irda/irda.h>

--BOKacYhQ+x31HxR3--
