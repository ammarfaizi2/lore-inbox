Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274806AbRJNQpy>; Sun, 14 Oct 2001 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274991AbRJNQpp>; Sun, 14 Oct 2001 12:45:45 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:37382 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S274806AbRJNQpc>;
	Sun, 14 Oct 2001 12:45:32 -0400
Message-ID: <3BC9C18C.6060808@si.rr.com>
Date: Sun, 14 Oct 2001 12:47:08 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.12-ac1: a few more net MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------060905040203080407090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905040203080407090705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I've attached a few more MODULE_LICENSE patches against 2.4.12-ac1 . 
A few more net MODULE_LICENSE patches to follow soon. Please review.
Regards,
Frank

--------------060905040203080407090705
Content-Type: text/plain;
 name="A2065"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="A2065"

--- drivers/net/a2065.c.old	Thu Apr 12 15:15:25 2001
+++ drivers/net/a2065.c	Sun Oct 14 11:51:13 2001
@@ -837,3 +837,4 @@
 
 module_init(a2065_probe);
 module_exit(a2065_cleanup);
+MODULE_LICENSE("GPL");

--------------060905040203080407090705
Content-Type: text/plain;
 name="ACENIC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ACENIC"

--- drivers/net/acenic.c.old	Fri Oct 12 18:42:54 2001
+++ drivers/net/acenic.c	Sun Oct 14 11:56:31 2001
@@ -145,10 +145,6 @@
 #endif
 
 
-#ifndef MODULE_LICENSE
-#define MODULE_LICENSE(a)
-#endif
-
 #ifndef wmb
 #define wmb()	mb()
 #endif

--------------060905040203080407090705
Content-Type: text/plain;
 name="ATARIB1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ATARIB1"

--- drivers/net/atari_bionet.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/atari_bionet.c	Sun Oct 14 11:59:49 2001
@@ -128,6 +128,7 @@
 unsigned int bionet_debug = NET_DEBUG;
 MODULE_PARM(bionet_debug, "i");
 MODULE_PARM_DESC(bionet_debug, "bionet debug level (0-2)");
+MODULE_LICENSE("GPL");
 
 static unsigned int bionet_min_poll_time = 2;
 

--------------060905040203080407090705
Content-Type: text/plain;
 name="ATARIL1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ATARIL1"

--- drivers/net/atarilance.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/atarilance.c	Sun Oct 14 12:03:10 2001
@@ -84,6 +84,7 @@
 #endif
 MODULE_PARM(lance_debug, "i");
 MODULE_PARM_DESC(lance_debug, "atarilance debug level (0-3)");
+MODULE_LICENSE("GPL");
 
 /* Print debug messages on probing? */
 #undef LANCE_DEBUG_PROBE

--------------060905040203080407090705
Content-Type: text/plain;
 name="ATARIP1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ATARIP1"

--- drivers/net/atari_pamsnet.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/atari_pamsnet.c	Sun Oct 14 12:01:29 2001
@@ -124,6 +124,7 @@
 unsigned int pamsnet_debug = NET_DEBUG;
 MODULE_PARM(pamsnet_debug, "i");
 MODULE_PARM_DESC(pamsnet_debug, "pamsnet debug enable (0-1)");
+MODULE_LICENSE("GPL");
 
 static unsigned int pamsnet_min_poll_time = 2;
 

--------------060905040203080407090705
Content-Type: text/plain;
 name="BAGETLAN"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAGETLAN"

--- drivers/net/bagetlance.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/bagetlance.c	Sun Oct 14 12:07:26 2001
@@ -60,6 +60,7 @@
 #endif
 MODULE_PARM(lance_debug, "i");
 MODULE_PARM_DESC(lance_debug, "Lance debug level (0-3)");
+MODULE_LICENSE("GPL");
 
 /* Print debug messages on probing? */
 #undef LANCE_DEBUG_PROBE

--------------060905040203080407090705
Content-Type: text/plain;
 name="BMAC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BMAC"

--- drivers/net/bmac.c.old	Sun Sep 30 20:38:57 2001
+++ drivers/net/bmac.c	Sun Oct 14 12:06:20 2001
@@ -1658,6 +1658,7 @@
 
 MODULE_AUTHOR("Randy Gobbel/Paul Mackerras");
 MODULE_DESCRIPTION("PowerMac BMAC ethernet driver.");
+MODULE_LICENSE("GPL");
 
 
 static void __exit bmac_cleanup (void)

--------------060905040203080407090705
Content-Type: text/plain;
 name="FEALNX"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="FEALNX"

--- drivers/net/fealnx.c.old	Sun Sep 30 20:38:59 2001
+++ drivers/net/fealnx.c	Sun Oct 14 12:10:12 2001
@@ -109,6 +109,7 @@
 
 MODULE_AUTHOR("Myson or whoever");
 MODULE_DESCRIPTION("Myson MTD-8xx 100/10M Ethernet PCI Adapter Driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM(max_interrupt_work, "i");
 //MODULE_PARM(min_pci_latency, "i");
 MODULE_PARM(debug, "i");

--------------060905040203080407090705
Content-Type: text/plain;
 name="FMV18X"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="FMV18X"

--- drivers/net/fmv18x.c.old	Tue Jul 17 21:53:55 2001
+++ drivers/net/fmv18x.c	Sun Oct 14 12:11:31 2001
@@ -632,6 +632,7 @@
 MODULE_PARM_DESC(io, "FMV-18X I/O address");
 MODULE_PARM_DESC(irq, "FMV-18X IRQ number");
 MODULE_PARM_DESC(net_debug, "FMV-18X debug level (0-1,5-6)");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------060905040203080407090705
Content-Type: text/plain;
 name="GT96100E"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GT96100E"

--- drivers/net/gt96100eth.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/gt96100eth.c	Sun Oct 14 12:14:39 2001
@@ -1250,3 +1250,5 @@
 }
 
 module_init(gt96100_probe);
+// shouldn't there be a module_exit ? 
+MODULE_LICENSE("GPL");

--------------060905040203080407090705
Content-Type: text/plain;
 name="GMAC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GMAC"

--- drivers/net/gmac.c.old	Sun Sep 30 20:38:59 2001
+++ drivers/net/gmac.c	Sun Oct 14 12:12:40 2001
@@ -1676,6 +1676,7 @@
 
 MODULE_AUTHOR("Paul Mackerras/Ben Herrenschmidt");
 MODULE_DESCRIPTION("PowerMac GMAC driver.");
+MODULE_LICENSE("GPL");
 
 static void __exit gmac_cleanup_module(void)
 {

--------------060905040203080407090705
Content-Type: text/plain;
 name="HPLANCE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPLANCE"

--- drivers/net/hplance.c.old	Thu Apr 12 15:15:25 2001
+++ drivers/net/hplance.c	Sun Oct 14 12:17:08 2001
@@ -226,6 +226,7 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 int init_module(void)
 {
         root_lance_dev = NULL;

--------------060905040203080407090705--

