Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCDWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCDWFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCDWFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:05:19 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:59721 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbWCDWFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:05:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nZObW1EyS20vsAOa4PQ9VUDoARZXqVwCikO+058Rp5avgVfR3wpzdqPNWGi4NyX1S959oIZ3271L9PqeRK74FVGZ98p1t0bKu7hg2O5nQK6IjTMcQXlOEUL++R+W6mqsRyyFWZnx16Fm+2auBMWd73deh4jCs2567UQvP5J+Wos=
Date: Sun, 5 Mar 2006 01:05:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Typos grab bag of the month
Message-ID: <20060304220506.GB8332@mipter.zuzino.mipt.ru>
References: <20060304211847.GA8332@mipter.zuzino.mipt.ru> <20060304134425.1bfb36bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304134425.1bfb36bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyeballed by jmc@ in OpenBSD.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Looks like typo in av7110.c is user-visible.

 Documentation/m68k/README.buddha         |    2 +-
 Documentation/networking/ifenslave.c     |    2 +-
 arch/arm/lib/copy_template.S             |    2 +-
 drivers/char/mxser.h                     |    2 +-
 drivers/char/synclink.c                  |    2 +-
 drivers/edac/edac_mc.c                   |    2 +-
 drivers/ide/ide.c                        |    2 +-
 drivers/media/dvb/dvb-core/demux.h       |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb-init.c |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb.h      |    2 +-
 drivers/media/dvb/ttpci/av7110.c         |    2 +-
 drivers/media/video/cpia.c               |    2 +-
 drivers/media/video/videocodec.h         |    2 +-
 drivers/media/video/zr36050.c            |    2 +-
 drivers/media/video/zr36060.c            |    2 +-
 drivers/media/video/zr36120_i2c.c        |    2 +-
 drivers/net/irda/nsc-ircc.c              |    2 +-
 drivers/net/sis900.c                     |    2 +-
 drivers/net/tulip/de4x5.c                |    2 +-
 drivers/net/tulip/pnic2.c                |    2 +-
 drivers/net/typhoon.c                    |    4 ++--
 drivers/net/wireless/orinoco.c           |    2 +-
 drivers/net/wireless/prism54/isl_ioctl.c |    2 +-
 drivers/scsi/3w-9xxx.c                   |    2 +-
 drivers/serial/8250.c                    |    2 +-
 drivers/serial/au1x00_uart.c             |    2 +-
 drivers/serial/serial_txx9.c             |    2 +-
 drivers/serial/sunsu.c                   |    2 +-
 drivers/usb/host/ohci-s3c2410.c          |    2 +-
 drivers/usb/net/zaurus.c                 |    2 +-
 fs/mbcache.c                             |    2 +-
 include/asm-parisc/pdc.h                 |    2 +-
 include/asm-sh/addrspace.h               |    2 +-
 include/asm-sparc64/floppy.h             |    2 +-
 include/linux/fb.h                       |    2 +-
 mm/mempolicy.c                           |    2 +-
 net/irda/af_irda.c                       |    6 +++---
 sound/pci/rme32.c                        |    8 ++++----
 sound/pci/rme96.c                        |    8 ++++----
 sound/pci/rme9652/hdspm.c                |    2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c          |    2 +-
 41 files changed, 50 insertions(+), 50 deletions(-)

--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -236,7 +236,7 @@
 
 
 /*
- * Abort preanble and completion macros.
+ * Abort preamble and completion macros.
  * If a fixup handler is required then those macros must surround it.
  * It is assumed that the fixup code will handle the private part of
  * the exit macro.
--- a/Documentation/m68k/README.buddha
+++ b/Documentation/m68k/README.buddha
@@ -29,7 +29,7 @@ address is written to $4a, then the whol
 $48, while it doesn't matter how often you're writing to $4a
 as  long as $48 is not touched.  After $48 has been written,
 the  whole card disappears from $e8 and is mapped to the new
-address just written.  Make shure $4a is written before $48,
+address just written.  Make sure $4a is written before $48,
 otherwise your chance is only 1:16 to find the board :-).
 
 The local memory-map is even active when mapped to $e8:
--- a/Documentation/networking/ifenslave.c
+++ b/Documentation/networking/ifenslave.c
@@ -87,7 +87,7 @@
  *	   would fail and generate an error message in the system log.
  * 	 - For opt_c: slave should not be set to the master's setting
  *	   while it is running. It was already set during enslave. To
- *	   simplify things, it is now handeled separately.
+ *	   simplify things, it is now handled separately.
  *
  *    - 2003/12/01 - Shmulik Hen <shmulik.hen at intel dot com>
  *	 - Code cleanup and style changes
--- a/drivers/char/mxser.h
+++ b/drivers/char/mxser.h
@@ -118,7 +118,7 @@
 
 // enable CTS interrupt
 #define MOXA_MUST_IER_ECTSI		0x80
-// eanble RTS interrupt
+// enable RTS interrupt
 #define MOXA_MUST_IER_ERTSI		0x40
 // enable Xon/Xoff interrupt
 #define MOXA_MUST_IER_XINT		0x20
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -6025,7 +6025,7 @@ static void usc_set_async_mode( struct m
 	 * <15..8>	?		RxFIFO IRQ Request Level
 	 *
 	 * Note: For async mode the receive FIFO level must be set
-	 * to 0 to aviod the situation where the FIFO contains fewer bytes
+	 * to 0 to avoid the situation where the FIFO contains fewer bytes
 	 * than the trigger level and no more data is expected.
 	 *
 	 * <7>		0		Exited Hunt IA (Interrupt Arm)
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -2117,7 +2117,7 @@ static int __init edac_mc_init(void)
 	/* perform check for first time to harvest boot leftovers */
 	do_edac_check();
 
-	/* Create the MC sysfs entires */
+	/* Create the MC sysfs entries */
 	if (edac_sysfs_memctrl_setup()) {
 		printk(KERN_ERR "EDAC MC: Error initializing sysfs code\n");
 		return -ENODEV;
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -452,7 +452,7 @@ void ide_hwif_release_regions(ide_hwif_t
  *	@hwif: hwif to update
  *	@tmp_hwif: template
  *
- *	Restore hwif to a previous state by copying most settngs
+ *	Restore hwif to a previous state by copying most settings
  *	from the template.
  */
 
--- a/drivers/media/dvb/dvb-core/demux.h
+++ b/drivers/media/dvb/dvb-core/demux.h
@@ -216,7 +216,7 @@ struct dmx_frontend {
 /*--------------------------------------------------------------------------*/
 
 /*
- * Flags OR'ed in the capabilites field of struct dmx_demux.
+ * Flags OR'ed in the capabilities field of struct dmx_demux.
  */
 
 #define DMX_TS_FILTERING                        1
--- a/drivers/media/dvb/dvb-usb/dvb-usb.h
+++ b/drivers/media/dvb/dvb-usb/dvb-usb.h
@@ -87,7 +87,7 @@ struct dvb_usb_device;
 
 /**
  * struct dvb_usb_properties - properties of a dvb-usb-device
- * @caps: capabilites of the DVB USB device.
+ * @caps: capabilities of the DVB USB device.
  * @pid_filter_count: number of PID filter position in the optional hardware
  *  PID-filter.
  *
--- a/drivers/media/dvb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
@@ -47,7 +47,7 @@ static int dvb_usb_init(struct dvb_usb_d
 
 	d->state = DVB_USB_STATE_INIT;
 
-/* check the capabilites and set appropriate variables */
+/* check the capabilities and set appropriate variables */
 
 /* speed - when running at FULL speed we need a HW PID filter */
 	if (d->udev->speed == USB_SPEED_FULL && !(d->props.caps & DVB_USB_HAS_PID_FILTER)) {
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -1439,7 +1439,7 @@ static int check_firmware(struct av7110*
 	len = ntohl(*(u32*) ptr);
 	ptr += 4;
 	if (len >= 512) {
-		printk("dvb-ttpci: dpram file is way to big.\n");
+		printk("dvb-ttpci: dpram file is way too big.\n");
 		return -EINVAL;
 	}
 	if (crc != crc32_le(0, ptr, len)) {
--- a/drivers/media/video/cpia.c
+++ b/drivers/media/video/cpia.c
@@ -3369,7 +3369,7 @@ static int cpia_do_ioctl(struct inode *i
 	//DBG("cpia_ioctl: %u\n", ioctlnr);
 
 	switch (ioctlnr) {
-	/* query capabilites */
+	/* query capabilities */
 	case VIDIOCGCAP:
 	{
 		struct video_capability *b = arg;
--- a/drivers/media/video/videocodec.h
+++ b/drivers/media/video/videocodec.h
@@ -56,7 +56,7 @@
    the slave is bound to it). Otherwise it doesn't need this functions and
    therfor they may not be initialized.
 
-   The other fuctions are just for convenience, as they are for shure used by
+   The other fuctions are just for convenience, as they are for sure used by
    most/all of the codecs. The last ones may be ommited, too. 
 
    See the structure declaration below for more information and which data has
--- a/drivers/media/video/zr36050.c
+++ b/drivers/media/video/zr36050.c
@@ -159,7 +159,7 @@ zr36050_wait_end (struct zr36050 *ptr)
 
 	while (!(zr36050_read_status1(ptr) & 0x4)) {
 		udelay(1);
-		if (i++ > 200000) {	// 200ms, there is for shure something wrong!!!
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
 			dprintk(1,
 				"%s: timout at wait_end (last status: 0x%02x)\n",
 				ptr->name, ptr->status1);
--- a/drivers/media/video/zr36060.c
+++ b/drivers/media/video/zr36060.c
@@ -161,7 +161,7 @@ zr36060_wait_end (struct zr36060 *ptr)
 
 	while (zr36060_read_status(ptr) & ZR060_CFSR_Busy) {
 		udelay(1);
-		if (i++ > 200000) {	// 200ms, there is for shure something wrong!!!
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
 			dprintk(1,
 				"%s: timout at wait_end (last status: 0x%02x)\n",
 				ptr->name, ptr->status);
--- a/drivers/media/video/zr36120_i2c.c
+++ b/drivers/media/video/zr36120_i2c.c
@@ -65,7 +65,7 @@ void attach_inform(struct i2c_bus *bus, 
 	 case I2C_DRIVERID_VIDEODECODER:
 		DEBUG(printk(CARD_INFO "decoder attached\n",CARD));
 
-		/* fetch the capabilites of the decoder */
+		/* fetch the capabilities of the decoder */
 		rv = i2c_control_device(&ztv->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_GET_CAPABILITIES, &dc);
 		if (rv) {
 			DEBUG(printk(CARD_DEBUG "decoder is not V4L aware!\n",CARD));
--- a/drivers/net/irda/nsc-ircc.c
+++ b/drivers/net/irda/nsc-ircc.c
@@ -705,7 +705,7 @@ static int nsc_ircc_init_39x(nsc_chip_t 
 	int cfg_base = info->cfg_base;
 	int enabled;
 
-	/* User is shure about his config... accept it. */
+	/* User is sure about his config... accept it. */
 	IRDA_DEBUG(2, "%s(): nsc_ircc_init_39x (user settings): "
 		   "io=0x%04x, irq=%d, dma=%d\n", 
 		   __FUNCTION__, info->fir_base, info->irq, info->dma);
--- a/drivers/net/sis900.c
+++ b/drivers/net/sis900.c
@@ -2282,7 +2282,7 @@ static void set_rx_mode(struct net_devic
 	int i, table_entries;
 	u32 rx_mode;
 
-	/* 635 Hash Table entires = 256(2^16) */
+	/* 635 Hash Table entries = 256(2^16) */
 	if((sis_priv->chipset_rev >= SIS635A_900_REV) ||
 			(sis_priv->chipset_rev == SIS900B_900_REV))
 		table_entries = 16;
--- a/drivers/net/tulip/de4x5.c
+++ b/drivers/net/tulip/de4x5.c
@@ -513,7 +513,7 @@ struct mii_phy {
     u_char  *rst;           /* Start of reset sequence in SROM           */
     u_int mc;               /* Media Capabilities                        */
     u_int ana;              /* NWay Advertisement                        */
-    u_int fdx;              /* Full DupleX capabilites for each media    */
+    u_int fdx;              /* Full DupleX capabilities for each media   */
     u_int ttm;              /* Transmit Threshold Mode for each media    */
     u_int mci;              /* 21142 MII Connector Interrupt info        */
 };
--- a/drivers/net/tulip/pnic2.c
+++ b/drivers/net/tulip/pnic2.c
@@ -199,7 +199,7 @@ void pnic2_lnk_change(struct net_device 
 	               /* negotiation ended successfully */
 
 	               /* get the link partners reply and mask out all but
-                        * bits 24-21 which show the partners capabilites
+                        * bits 24-21 which show the partners capabilities
                         * and match those to what we advertised
                         *
                         * then begin to interpret the results of the negotiation.
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -208,7 +208,7 @@ static struct typhoon_card_info typhoon_
 };
 
 /* Notes on the new subsystem numbering scheme:
- * bits 0-1 indicate crypto capabilites: (0) variable, (1) DES, or (2) 3DES
+ * bits 0-1 indicate crypto capabilities: (0) variable, (1) DES, or (2) 3DES
  * bit 4 indicates if this card has secured firmware (we don't support it)
  * bit 8 indicates if this is a (0) copper or (1) fiber card
  * bits 12-16 indicate card type: (0) client and (1) server
@@ -788,7 +788,7 @@ typhoon_start_tx(struct sk_buff *skb, st
 	/* we have two rings to choose from, but we only use txLo for now
 	 * If we start using the Hi ring as well, we'll need to update
 	 * typhoon_stop_runtime(), typhoon_interrupt(), typhoon_num_free_tx(),
-	 * and TXHI_ENTIRES to match, as well as update the TSO code below
+	 * and TXHI_ENTRIES to match, as well as update the TSO code below
 	 * to get the right DMA address
 	 */
 	txRing = &tp->txLoRing;
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -3858,7 +3858,7 @@ static int orinoco_ioctl_setscan(struct 
 	unsigned long flags;
 
 	/* Note : you may have realised that, as this is a SET operation,
-	 * this is priviledged and therefore a normal user can't
+	 * this is privileged and therefore a normal user can't
 	 * perform scanning.
 	 * This is not an error, while the device perform scanning,
 	 * traffic doesn't flow, so it's a perfect DoS...
--- a/drivers/net/wireless/prism54/isl_ioctl.c
+++ b/drivers/net/wireless/prism54/isl_ioctl.c
@@ -747,7 +747,7 @@ prism54_get_essid(struct net_device *nde
 
 	if (essid->length) {
 		dwrq->flags = 1;	/* set ESSID to ON for Wireless Extensions */
-		/* if it is to big, trunk it */
+		/* if it is too big, trunk it */
 		dwrq->length = min((u8)IW_ESSID_MAX_SIZE, essid->length);
 	} else {
 		dwrq->flags = 0;
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1030,7 +1030,7 @@ static void twa_free_request_id(TW_Devic
 	tw_dev->free_tail = (tw_dev->free_tail + 1) % TW_Q_LENGTH;
 } /* End twa_free_request_id() */
 
-/* This function will get parameter table entires from the firmware */
+/* This function will get parameter table entries from the firmware */
 static void *twa_get_param(TW_Device_Extension *tw_dev, int request_id, int table_id, int parameter_id, int parameter_size_bytes)
 {
 	TW_Command_Full *full_command_packet;
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1528,7 +1528,7 @@ static int serial8250_startup(struct uar
 
 	/*
 	 * Clear the FIFO buffers and disable them.
-	 * (they will be reeanbled in set_termios())
+	 * (they will be reenabled in set_termios())
 	 */
 	serial8250_clear_fifos(up);
 
--- a/drivers/serial/au1x00_uart.c
+++ b/drivers/serial/au1x00_uart.c
@@ -603,7 +603,7 @@ static int serial8250_startup(struct uar
 
 	/*
 	 * Clear the FIFO buffers and disable them.
-	 * (they will be reeanbled in set_termios())
+	 * (they will be reenabled in set_termios())
 	 */
 	if (uart_config[up->port.type].flags & UART_CLEAR_FIFO) {
 		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -481,7 +481,7 @@ static int serial_txx9_startup(struct ua
 
 	/*
 	 * Clear the FIFO buffers and disable them.
-	 * (they will be reeanbled in set_termios())
+	 * (they will be reenabled in set_termios())
 	 */
 	sio_set(up, TXX9_SIFCR,
 		TXX9_SIFCR_TFRST | TXX9_SIFCR_RFRST | TXX9_SIFCR_FRSTE);
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -644,7 +644,7 @@ static int sunsu_startup(struct uart_por
 
 	/*
 	 * Clear the FIFO buffers and disable them.
-	 * (they will be reeanbled in set_termios())
+	 * (they will be reenabled in set_termios())
 	 */
 	if (uart_config[up->port.type].flags & UART_CLEAR_FIFO) {
 		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -158,7 +158,7 @@ static int ohci_s3c2410_hub_control (
 		"s3c2410_hub_control(%p,0x%04x,0x%04x,0x%04x,%p,%04x)\n",
 		hcd, typeReq, wValue, wIndex, buf, wLength);
 
-	/* if we are only an humble host without any special capabilites
+	/* if we are only an humble host without any special capabilities
 	 * process the request straight away and exit */
 
 	if (info == NULL) {
--- a/drivers/usb/net/zaurus.c
+++ b/drivers/usb/net/zaurus.c
@@ -217,7 +217,7 @@ static int blan_mdlm_bind(struct usbnet 
 			 * with devices that use it and those that don't.
 			 */
 			if ((detail->bDetailData[1] & ~0x02) != 0x01) {
-				/* bmDataCapabilites == 0 would be fine too,
+				/* bmDataCapabilities == 0 would be fine too,
 				 * but framing is minidriver-coupled for now.
 				 */
 bad_detail:
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -311,7 +311,7 @@ fail:
 /*
  * mb_cache_shrink()
  *
- * Removes all cache entires of a device from the cache. All cache entries
+ * Removes all cache entries of a device from the cache. All cache entries
  * currently in use cannot be freed, and thus remain in the cache. All others
  * are freed.
  *
--- a/include/asm-parisc/pdc.h
+++ b/include/asm-parisc/pdc.h
@@ -333,7 +333,7 @@ struct pdc_model {		/* for PDC_MODEL */
 	unsigned long curr_key;
 };
 
-/* Values for PDC_MODEL_CAPABILITES non-equivalent virtual aliasing support */
+/* Values for PDC_MODEL_CAPABILITIES non-equivalent virtual aliasing support */
 
 #define PDC_MODEL_IOPDIR_FDC            (1 << 2)        /* see sba_iommu.c */
 #define PDC_MODEL_NVA_MASK		(3 << 4)
--- a/include/asm-sh/addrspace.h
+++ b/include/asm-sh/addrspace.h
@@ -13,7 +13,7 @@
 
 #include <asm/cpu/addrspace.h>
 
-/* Memory segments (32bit Priviledged mode addresses)  */
+/* Memory segments (32bit Privileged mode addresses)  */
 #define P0SEG		0x00000000
 #define P1SEG		0x80000000
 #define P2SEG		0xa0000000
--- a/include/asm-sparc64/floppy.h
+++ b/include/asm-sparc64/floppy.h
@@ -738,7 +738,7 @@ static unsigned long __init sun_floppy_i
 		if (!sun_floppy_types[0] && sun_floppy_types[1]) {
 			/*
 			 * Set the drive exchange bit in FCR on NS87303,
-			 * make shure other bits are sane before doing so.
+			 * make sure other bits are sane before doing so.
 			 */
 			ns87303_modify(config, FER, FER_EDM, 0);
 			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -734,7 +734,7 @@ struct fb_tile_ops {
 
 /* A driver may set this flag to indicate that it does want a set_par to be
  * called every time when fbcon_switch is executed. The advantage is that with
- * this flag set you can really be shure that set_par is always called before
+ * this flag set you can really be sure that set_par is always called before
  * any of the functions dependant on the correct hardware state or altering
  * that state, even if you are using some broken X releases. The disadvantage
  * is that it introduces unwanted delays to every console switch if set_par
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -937,7 +937,7 @@ asmlinkage long sys_migrate_pages(pid_t 
 	/*
 	 * Check if this process has the right to modify the specified
 	 * process. The right exists if the process has administrative
-	 * capabilities, superuser priviledges or the same
+	 * capabilities, superuser privileges or the same
 	 * userid as the target process.
 	 */
 	if ((current->euid != task->suid) && (current->euid != task->uid) &&
--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -1302,7 +1302,7 @@ static int irda_sendmsg(struct kiocb *io
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
-	/* Check that we don't send out to big frames */
+	/* Check that we don't send out too big frames */
 	if (len > self->max_data_size) {
 		IRDA_DEBUG(2, "%s(), Chopping frame from %zd to %d bytes!\n",
 			   __FUNCTION__, len, self->max_data_size);
@@ -1546,7 +1546,7 @@ static int irda_sendmsg_dgram(struct kio
 	IRDA_ASSERT(self != NULL, return -1;);
 
 	/*
-	 * Check that we don't send out to big frames. This is an unreliable
+	 * Check that we don't send out too big frames. This is an unreliable
 	 * service, so we have no fragmentation and no coalescence
 	 */
 	if (len > self->max_data_size) {
@@ -1642,7 +1642,7 @@ static int irda_sendmsg_ultra(struct kio
 	}
 
 	/*
-	 * Check that we don't send out to big frames. This is an unreliable
+	 * Check that we don't send out too big frames. This is an unreliable
 	 * service, so we have no fragmentation and no coalescence
 	 */
 	if (len > self->max_data_size) {
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -313,7 +313,7 @@ static int snd_rme32_capture_copy(struct
 }
 
 /*
- * SPDIF I/O capabilites (half-duplex mode)
+ * SPDIF I/O capabilities (half-duplex mode)
  */
 static struct snd_pcm_hardware snd_rme32_spdif_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP_IOMEM |
@@ -339,7 +339,7 @@ static struct snd_pcm_hardware snd_rme32
 };
 
 /*
- * ADAT I/O capabilites (half-duplex mode)
+ * ADAT I/O capabilities (half-duplex mode)
  */
 static struct snd_pcm_hardware snd_rme32_adat_info =
 {
@@ -364,7 +364,7 @@ static struct snd_pcm_hardware snd_rme32
 };
 
 /*
- * SPDIF I/O capabilites (full-duplex mode)
+ * SPDIF I/O capabilities (full-duplex mode)
  */
 static struct snd_pcm_hardware snd_rme32_spdif_fd_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP |
@@ -390,7 +390,7 @@ static struct snd_pcm_hardware snd_rme32
 };
 
 /*
- * ADAT I/O capabilites (full-duplex mode)
+ * ADAT I/O capabilities (full-duplex mode)
  */
 static struct snd_pcm_hardware snd_rme32_adat_fd_info =
 {
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2256,7 +2256,7 @@ static int snd_hdspm_create_controls(str
 	}
 
 	/* Channel playback mixer as default control 
-	   Note: the whole matrix would be 128*HDSPM_MIXER_CHANNELS Faders, thats to big for any alsamixer 
+	   Note: the whole matrix would be 128*HDSPM_MIXER_CHANNELS Faders, thats too big for any alsamixer 
 	   they are accesible via special IOCTL on hwdep
 	   and the mixer 2dimensional mixer control */
 
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -359,7 +359,7 @@ snd_rme96_capture_copy(struct snd_pcm_su
 }
 
 /*
- * Digital output capabilites (S/PDIF)
+ * Digital output capabilities (S/PDIF)
  */
 static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 {
@@ -388,7 +388,7 @@ static struct snd_pcm_hardware snd_rme96
 };
 
 /*
- * Digital input capabilites (S/PDIF)
+ * Digital input capabilities (S/PDIF)
  */
 static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 {
@@ -417,7 +417,7 @@ static struct snd_pcm_hardware snd_rme96
 };
 
 /*
- * Digital output capabilites (ADAT)
+ * Digital output capabilities (ADAT)
  */
 static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 {
@@ -442,7 +442,7 @@ static struct snd_pcm_hardware snd_rme96
 };
 
 /*
- * Digital input capabilites (ADAT)
+ * Digital input capabilities (ADAT)
  */
 static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 {
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -404,7 +404,7 @@ static void usX2Y_usbpcm_subs_startup(st
 	struct usX2Ydev * usX2Y = subs->usX2Y;
 	usX2Y->prepare_subs = subs;
 	subs->urb[0]->start_frame = -1;
-	smp_wmb();	// Make shure above modifications are seen by i_usX2Y_subs_startup()
+	smp_wmb();	// Make sure above modifications are seen by i_usX2Y_subs_startup()
 	usX2Y_urbs_set_complete(usX2Y, i_usX2Y_usbpcm_subs_startup);
 }
 

