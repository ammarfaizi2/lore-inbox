Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752479AbWAFQdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbWAFQdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbWAFQdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:33:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56331 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752480AbWAFQdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:33:33 -0500
Date: Fri, 6 Jan 2006 17:33:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] spelling: s/trough/through/
Message-ID: <20060106163328.GO12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/mach-omap1/board-perseus2.c        |    2 +-
 drivers/cdrom/cm206.c                       |    2 +-
 drivers/net/pcmcia/xirc2ps_cs.c             |    2 +-
 drivers/parisc/led.c                        |    2 +-
 drivers/usb/serial/usb-serial.c             |    2 +-
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    4 ++--
 net/netfilter/nf_conntrack_proto_tcp.c      |    4 ++--
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c      |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.15-mm1-full/arch/arm/mach-omap1/board-perseus2.c.old	2006-01-06 17:00:09.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/arm/mach-omap1/board-perseus2.c	2006-01-06 17:00:19.000000000 +0100
@@ -184,7 +184,7 @@
 	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
 
 	/*
-	 * Ethernet support trough the debug board
+	 * Ethernet support through the debug board
 	 * CS1 timings setup
 	 */
 	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
--- linux-2.6.15-mm1-full/drivers/cdrom/cm206.c.old	2006-01-06 17:00:28.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/cdrom/cm206.c	2006-01-06 17:00:34.000000000 +0100
@@ -32,7 +32,7 @@
  18 mrt 1995: 0.24 Working background read-ahead. (still problems)
  26 mrt 1995: 0.25 Multi-session ioctl added (kernel v1.2).
               Statistics implemented, though separate stats206.h.
-	      Accessible trough ioctl 0x1000 (just a number).
+	      Accessible through ioctl 0x1000 (just a number).
 	      Hard to choose between v1.2 development and 1.1.75.
 	      Bottom-half doesn't work with 1.2...
 	      0.25a: fixed... typo. Still problems...
--- linux-2.6.15-mm1-full/drivers/net/pcmcia/xirc2ps_cs.c.old	2006-01-06 17:00:42.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/pcmcia/xirc2ps_cs.c	2006-01-06 17:00:49.000000000 +0100
@@ -1598,7 +1598,7 @@
     switch(cmd) {
       case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
 	data[0] = 0;		/* we have only this address */
-	/* fall trough */
+	/* fall through */
       case SIOCGMIIREG:		/* Read the specified MII register. */
 	data[3] = mii_rd(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 	break;
--- linux-2.6.15-mm1-full/drivers/parisc/led.c.old	2006-01-06 17:00:57.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/parisc/led.c	2006-01-06 17:01:02.000000000 +0100
@@ -347,7 +347,7 @@
    ** 
    ** led_get_net_activity()
    ** 
-   ** calculate if there was TX- or RX-troughput on the network interfaces
+   ** calculate if there was TX- or RX-throughput on the network interfaces
    ** (analog to dev_get_info() from net/core/dev.c)
    **   
  */
--- linux-2.6.15-mm1-full/drivers/usb/serial/usb-serial.c.old	2006-01-06 17:01:10.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/usb/serial/usb-serial.c	2006-01-06 17:01:16.000000000 +0100
@@ -617,7 +617,7 @@
 	const struct usb_device_id *id;
 	struct usb_serial_driver *t;
 
-	/* List trough know devices and see if the usb id matches */
+	/* List through know devices and see if the usb id matches */
 	list_for_each(p, &usb_serial_driver_list) {
 		t = list_entry(p, struct usb_serial_driver, driver_list);
 		id = get_iface_id(t, iface);
--- linux-2.6.15-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.old	2006-01-06 17:01:46.000000000 +0100
+++ linux-2.6.15-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2006-01-06 17:01:56.000000000 +0100
@@ -995,7 +995,7 @@
 		        || (!test_bit(IPS_ASSURED_BIT, &conntrack->status)
 		            && conntrack->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == conntrack->proto.tcp.last_end) {
-			/* RST sent to invalid SYN or ACK we had let trough
+			/* RST sent to invalid SYN or ACK we had let through
 			 * at a) and c) above:
 			 *
 			 * a) SYN was in window then
@@ -1006,7 +1006,7 @@
 			 * segments we ignored. */
 			goto in_window;
 		}
-		/* Just fall trough */
+		/* Just fall through */
 	default:
 		/* Keep compilers happy. */
 		break;
--- linux-2.6.15-mm1-full/net/netfilter/nf_conntrack_proto_tcp.c.old	2006-01-06 17:02:07.000000000 +0100
+++ linux-2.6.15-mm1-full/net/netfilter/nf_conntrack_proto_tcp.c	2006-01-06 17:02:14.000000000 +0100
@@ -988,7 +988,7 @@
 		        || (!test_bit(IPS_ASSURED_BIT, &conntrack->status)
 		            && conntrack->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == conntrack->proto.tcp.last_end) {
-			/* RST sent to invalid SYN or ACK we had let trough
+			/* RST sent to invalid SYN or ACK we had let through
 			 * at a) and c) above:
 			 *
 			 * a) SYN was in window then
@@ -999,7 +999,7 @@
 			 * segments we ignored. */
 			goto in_window;
 		}
-		/* Just fall trough */
+		/* Just fall through */
 	default:
 		/* Keep compilers happy. */
 		break;
--- linux-2.6.15-mm1-full/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c.old	2006-01-06 17:02:22.000000000 +0100
+++ linux-2.6.15-mm1-full/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2006-01-06 17:02:33.000000000 +0100
@@ -209,7 +209,7 @@
 	case SNDRV_PCM_FORMAT_S24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3BE:
 		chip->pcm_sample = 3;
-		/* fall trough */
+		/* fall through */
 	default: /* 24-bit */
 		aval = AK4117_DIF_24R;
 		chip->pcm_frame = 3;

