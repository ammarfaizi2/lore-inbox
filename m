Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTBYD3V>; Mon, 24 Feb 2003 22:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBYD3N>; Mon, 24 Feb 2003 22:29:13 -0500
Received: from [24.77.48.240] ([24.77.48.240]:30051 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S266135AbTBYD10>;
	Mon, 24 Feb 2003 22:27:26 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bj132710@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - initial
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    intial -> initial
    intially -> initially
    intiali[sz]e -> initiali[sz]e
    intiali[sz]ed -> initiali[sz]ed
    intiali[sz]es -> initiali[sz]es
    intiali[sz]ation -> initiali[sz]ation

Fixes 32 occurrences in all.

diff -ur 2.5.63a/arch/arm/mach-iop310/mm.c 2.5.63b/arch/arm/mach-iop310/mm.c
--- 2.5.63a/arch/arm/mach-iop310/mm.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/arch/arm/mach-iop310/mm.c	Mon Feb 24 17:55:42 2003
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-iop310/mm.c
  *
- * Low level memory intialization for IOP310 based systems
+ * Low level memory initialization for IOP310 based systems
  *
  * Author: Nicolas Pitre <npitre@mvista.com>
  *
diff -ur 2.5.63a/arch/ia64/sn/kernel/setup.c 2.5.63b/arch/ia64/sn/kernel/setup.c
--- 2.5.63a/arch/ia64/sn/kernel/setup.c	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/arch/ia64/sn/kernel/setup.c	Mon Feb 24 17:55:44 2003
@@ -153,7 +153,7 @@
 /**
  * early_sn_setup - early setup routine for SN platforms
  *
- * Sets up an intial console to aid debugging.  Intended primarily
+ * Sets up an initial console to aid debugging.  Intended primarily
  * for bringup, it's only called if %BRINGUP and %CONFIG_IA64_EARLY_PRINTK
  * are turned on.  See start_kernel() in init/main.c.
  */
diff -ur 2.5.63a/arch/sh/kernel/pci-sh7751.c 2.5.63b/arch/sh/kernel/pci-sh7751.c
--- 2.5.63a/arch/sh/kernel/pci-sh7751.c	Mon Feb 24 11:05:37 2003
+++ 2.5.63b/arch/sh/kernel/pci-sh7751.c	Mon Feb 24 17:55:51 2003
@@ -285,7 +285,7 @@
 	struct pci_ops *bios = NULL;
 	struct pci_ops *dir = NULL;
 
-	PCIDBG(1,"PCI: Starting intialization.\n");
+	PCIDBG(1,"PCI: Starting initialization.\n");
 #ifdef CONFIG_PCI_BIOS
 	if ((pci_probe & PCI_PROBE_BIOS) && ((bios = pci_find_bios()))) {
 		pci_probe |= PCI_BIOS_SORT;
diff -ur 2.5.63a/drivers/acpi/events/evrgnini.c 2.5.63b/drivers/acpi/events/evrgnini.c
--- 2.5.63a/drivers/acpi/events/evrgnini.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/acpi/events/evrgnini.c	Mon Feb 24 17:55:53 2003
@@ -410,7 +410,7 @@
  *              Get the appropriate address space handler for a newly
  *              created region.
  *
- *              This also performs address space specific intialization.  For
+ *              This also performs address space specific initialization.  For
  *              example, PCI regions must have an _ADR object that contains
  *              a PCI address in the scope of the definition.  This address is
  *              required to perform an access to PCI config space.
diff -ur 2.5.63a/drivers/atm/iphase.c 2.5.63b/drivers/atm/iphase.c
--- 2.5.63a/drivers/atm/iphase.c	Mon Feb 24 11:05:46 2003
+++ 2.5.63b/drivers/atm/iphase.c	Mon Feb 24 17:55:55 2003
@@ -2071,7 +2071,7 @@
 		- UBR Table size is 4K  
 		- UBR wait queue is 4K  
 	   since the table and wait queues are contiguous, all the bytes   
-	   can be intialized by one memeset.  
+	   can be initialized by one memeset.  
 	*/  
         
         vcsize_sel = 0;
diff -ur 2.5.63a/drivers/i2c/i2c-adap-ite.c 2.5.63b/drivers/i2c/i2c-adap-ite.c
--- 2.5.63a/drivers/i2c/i2c-adap-ite.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/i2c/i2c-adap-ite.c	Mon Feb 24 17:55:56 2003
@@ -265,7 +265,7 @@
 MODULE_PARM(i2c_debug,"i");
 
 
-/* Called when module is loaded or when kernel is intialized.
+/* Called when module is loaded or when kernel is initialized.
  * If MODULES is defined when this file is compiled, then this function will
  * resolve to init_module (the function called when insmod is invoked for a
  * module).  Otherwise, this function is called early in the boot, when the
diff -ur 2.5.63a/drivers/i2c/i2c-algo-ite.c 2.5.63b/drivers/i2c/i2c-algo-ite.c
--- 2.5.63a/drivers/i2c/i2c-algo-ite.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/i2c/i2c-algo-ite.c	Mon Feb 24 17:55:58 2003
@@ -860,7 +860,7 @@
  * is loaded via insmod) when this file is compiled with MODULES defined.
  * Otherwise (i.e. if you want this driver statically linked to the kernel),
  * a pointer to this function is stored in a table and called
- * during the intialization of the kernel (in do_basic_setup in /init/main.c) 
+ * during the initialization of the kernel (in do_basic_setup in /init/main.c) 
  *
  * All this functionality is complements of the macros defined in linux/init.h
  */
diff -ur 2.5.63a/drivers/ieee1394/dv1394-private.h 2.5.63b/drivers/ieee1394/dv1394-private.h
--- 2.5.63a/drivers/ieee1394/dv1394-private.h	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/ieee1394/dv1394-private.h	Mon Feb 24 17:56:00 2003
@@ -488,7 +488,7 @@
 	struct frame *frames[DV1394_MAX_FRAMES];
 	
 	/* n_frames also serves as an indicator that this struct video_card is
-	   intialized and ready to run DMA buffers */
+	   initialized and ready to run DMA buffers */
 
 	int n_frames;
 
diff -ur 2.5.63a/drivers/isdn/eicon/adapter.h 2.5.63b/drivers/isdn/eicon/adapter.h
--- 2.5.63a/drivers/isdn/eicon/adapter.h	Mon Feb 24 11:05:44 2003
+++ 2.5.63b/drivers/isdn/eicon/adapter.h	Mon Feb 24 17:56:02 2003
@@ -185,7 +185,7 @@
 IDI_CALL	DivasIdiRequest[];
 
 /*
- * intialisation entry point
+ * initialisation entry point
  */
 
 int		DivasInit(void);
diff -ur 2.5.63a/drivers/net/hamachi.c 2.5.63b/drivers/net/hamachi.c
--- 2.5.63a/drivers/net/hamachi.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/net/hamachi.c	Mon Feb 24 17:56:05 2003
@@ -316,7 +316,7 @@
     the new buffer or the function returns non-zero which should case the
     scheduler to reschedule the buffer later.
 
-01/15/1999 EPK Some adjustments were made to the chip intialization.  
+01/15/1999 EPK Some adjustments were made to the chip initialization.  
     End-to-end flow control should now be fully active and the interrupt 
     algorithm vars have been changed.  These could probably use further tuning.
 
diff -ur 2.5.63a/drivers/net/sk_mca.c 2.5.63b/drivers/net/sk_mca.c
--- 2.5.63a/drivers/net/sk_mca.c	Mon Feb 24 11:05:36 2003
+++ 2.5.63b/drivers/net/sk_mca.c	Mon Feb 24 17:56:07 2003
@@ -45,7 +45,7 @@
   May 23nd, 1999
 	can receive frames, send frames
   May 24th, 1999
-        modularized intialization of LANCE
+        modularized initialization of LANCE
         loadable as module
 	still Tx problem :-(
   May 26th, 1999
diff -ur 2.5.63a/drivers/net/tokenring/lanstreamer.c 2.5.63b/drivers/net/tokenring/lanstreamer.c
--- 2.5.63a/drivers/net/tokenring/lanstreamer.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/net/tokenring/lanstreamer.c	Mon Feb 24 17:56:11 2003
@@ -542,7 +542,7 @@
 
 	writew(readw(streamer_mmio + LAPWWO) + 6, streamer_mmio + LAPA);
 	if (readw(streamer_mmio + LAPD)) {
-		printk(KERN_INFO "tokenring card intialization failed. errorcode : %x\n",
+		printk(KERN_INFO "tokenring card initialization failed. errorcode : %x\n",
 		       ntohs(readw(streamer_mmio + LAPD)));
 		release_region(dev->base_addr, STREAMER_IO_SPACE);
 		return -1;
diff -ur 2.5.63a/drivers/net/tokenring/olympic.c 2.5.63b/drivers/net/tokenring/olympic.c
--- 2.5.63a/drivers/net/tokenring/olympic.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/net/tokenring/olympic.c	Mon Feb 24 17:56:15 2003
@@ -384,7 +384,7 @@
 }
 #endif	
 	if(readw(init_srb+6)) {
-		printk(KERN_INFO "tokenring card intialization failed. errorcode : %x\n",readw(init_srb+6));
+		printk(KERN_INFO "tokenring card initialization failed. errorcode : %x\n",readw(init_srb+6));
 		return -ENODEV;
 	}
 
diff -ur 2.5.63a/drivers/net/wan/sdlamain.c 2.5.63b/drivers/net/wan/sdlamain.c
--- 2.5.63a/drivers/net/wan/sdlamain.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/net/wan/sdlamain.c	Mon Feb 24 17:56:16 2003
@@ -38,7 +38,7 @@
 *				replaced it with 'wandev->enable_tx_int'. 
 * May 29, 1997	Jaspreet Singh	Flow Control Problem
 *				added "wandev->tx_int_enabled=1" line in the
-*				init module. This line intializes the flag for 
+*				init module. This line initializes the flag for 
 *				preventing Interrupt disabled with device set to
 *				busy
 * Jan 15, 1997	Gene Kozin	Version 3.1.0
diff -ur 2.5.63a/drivers/net/wan/wanpipe_multppp.c 2.5.63b/drivers/net/wan/wanpipe_multppp.c
--- 2.5.63a/drivers/net/wan/wanpipe_multppp.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/net/wan/wanpipe_multppp.c	Mon Feb 24 17:56:18 2003
@@ -2283,7 +2283,7 @@
 
 	Intr_test_counter = 0;
 
-	/* The critical flag is unset because during intialization (if_open) 
+	/* The critical flag is unset because during initialization (if_open) 
 	 * we want the interrupts to be enabled so that when the wpc_isr is
 	 * called it does not exit due to critical flag set.
 	 */ 
diff -ur 2.5.63a/drivers/net/wireless/orinoco.c 2.5.63b/drivers/net/wireless/orinoco.c
--- 2.5.63a/drivers/net/wireless/orinoco.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/net/wireless/orinoco.c	Mon Feb 24 17:56:22 2003
@@ -4166,7 +4166,7 @@
 	e = create_proc_read_entry("buf", S_IFREG | S_IRUGO,
 					       priv->dir_dev, orinoco_proc_get_hermes_buf, priv);
 	if (! e) {
-		printk(KERN_ERR "Unable to intialize /proc/hermes/%s/buf\n", dev->name);
+		printk(KERN_ERR "Unable to initialize /proc/hermes/%s/buf\n", dev->name);
 		goto fail;
 	}
 
diff -ur 2.5.63a/drivers/scsi/FlashPoint.c 2.5.63b/drivers/scsi/FlashPoint.c
--- 2.5.63a/drivers/scsi/FlashPoint.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/scsi/FlashPoint.c	Mon Feb 24 17:56:26 2003
@@ -7529,7 +7529,7 @@
  *
  *   $Workfile:   phase.c  $
  *
- *   Description:  Functions to intially handle the SCSI bus phase when
+ *   Description:  Functions to initially handle the SCSI bus phase when
  *                 the target asserts request (and the automation is not
  *                 enabled to handle the situation).
  *
diff -ur 2.5.63a/drivers/scsi/aacraid/comminit.c 2.5.63b/drivers/scsi/aacraid/comminit.c
--- 2.5.63a/drivers/scsi/aacraid/comminit.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/scsi/aacraid/comminit.c	Mon Feb 24 17:56:29 2003
@@ -210,7 +210,7 @@
 
 /**
  *	aac_comm_init	-	Initialise FSA data structures
- *	@dev:	Adapter to intialise
+ *	@dev:	Adapter to initialise
  *
  *	Initializes the data structures that are required for the FSA commuication
  *	interface to operate. 
diff -ur 2.5.63a/drivers/scsi/aacraid/commsup.c 2.5.63b/drivers/scsi/aacraid/commsup.c
--- 2.5.63a/drivers/scsi/aacraid/commsup.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/scsi/aacraid/commsup.c	Mon Feb 24 17:56:31 2003
@@ -79,7 +79,7 @@
  *	fib_setup	-	setup the fibs
  *	@dev: Adapter to set up
  *
- *	Allocate the PCI space for the fibs, map it and then intialise the
+ *	Allocate the PCI space for the fibs, map it and then initialise the
  *	fib area, the unmapped fib data and also the free list
  */
 
diff -ur 2.5.63a/drivers/scsi/gdth.c 2.5.63b/drivers/scsi/gdth.c
--- 2.5.63a/drivers/scsi/gdth.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/scsi/gdth.c	Mon Feb 24 17:56:33 2003
@@ -28,7 +28,7 @@
  *                                                                      *
  * $Log: gdth.c,v $
  * Revision 1.61  2002/10/03 09:35:22  boji
- * Fixed SCREENSERVICE intialisation in SMP cases.
+ * Fixed SCREENSERVICE initialisation in SMP cases.
  * Added checks for gdth_polling before GDTH_HA_LOCK
  *
  * Revision 1.60  2002/02/05 09:35:22  achim
diff -ur 2.5.63a/drivers/usb/misc/auerswald.c 2.5.63b/drivers/usb/misc/auerswald.c
--- 2.5.63a/drivers/usb/misc/auerswald.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/usb/misc/auerswald.c	Mon Feb 24 17:56:34 2003
@@ -1946,7 +1946,7 @@
         if (intf->altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
-	/* allocate memory for our device and intialize it */
+	/* allocate memory for our device and initialize it */
 	cp = kmalloc (sizeof(auerswald_t), GFP_KERNEL);
 	if (cp == NULL) {
 		err ("out of memory");
diff -ur 2.5.63a/drivers/usb/usb-skeleton.c 2.5.63b/drivers/usb/usb-skeleton.c
--- 2.5.63a/drivers/usb/usb-skeleton.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/drivers/usb/usb-skeleton.c	Mon Feb 24 17:56:36 2003
@@ -498,7 +498,7 @@
 		goto exit;
 	}
 
-	/* allocate memory for our device state and intialize it */
+	/* allocate memory for our device state and initialize it */
 	dev = kmalloc (sizeof(struct usb_skel), GFP_KERNEL);
 	if (dev == NULL) {
 		err ("Out of memory");
diff -ur 2.5.63a/drivers/video/controlfb.c 2.5.63b/drivers/video/controlfb.c
--- 2.5.63a/drivers/video/controlfb.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/video/controlfb.c	Mon Feb 24 17:56:37 2003
@@ -554,7 +554,7 @@
 
 
 /*
- * Called from fbmem.c for probing & intializing
+ * Called from fbmem.c for probing & initializing
  */
 int __init control_init(void)
 {
diff -ur 2.5.63a/fs/reiserfs/journal.c 2.5.63b/fs/reiserfs/journal.c
--- 2.5.63a/fs/reiserfs/journal.c	Mon Feb 24 11:05:34 2003
+++ 2.5.63b/fs/reiserfs/journal.c	Mon Feb 24 17:56:39 2003
@@ -1931,7 +1931,7 @@
 			printk( "journal_init_dev: '%s' is not a block device", jdev_name );
 			result = -ENOTBLK;
 		} else if( jdev_inode -> i_bdev == NULL ) {
-			printk( "journal_init_dev: bdev unintialized for '%s'", jdev_name );
+			printk( "journal_init_dev: bdev uninitialized for '%s'", jdev_name );
 			result = -ENOMEM;
 		} else  {
 			/* ok */
diff -ur 2.5.63a/net/irda/irsyms.c 2.5.63b/net/irda/irsyms.c
--- 2.5.63a/net/irda/irsyms.c	Mon Feb 24 11:05:44 2003
+++ 2.5.63b/net/irda/irsyms.c	Mon Feb 24 17:56:41 2003
@@ -254,7 +254,7 @@
 /*
  * Function irda_init (void)
  *
- *  Protocol stack intialisation entry point.
+ *  Protocol stack initialisation entry point.
  *  Initialise the various components of the IrDA stack
  */
 int __init irda_init(void)
diff -ur 2.5.63a/net/sctp/sm_statefuns.c 2.5.63b/net/sctp/sm_statefuns.c
--- 2.5.63a/net/sctp/sm_statefuns.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/net/sctp/sm_statefuns.c	Mon Feb 24 17:56:43 2003
@@ -1413,7 +1413,7 @@
  *      at about the same time but the peer endpoint started its INIT
  *      after responding to the local endpoint's INIT
  */
-/* This case represents an intialization collision.  */
+/* This case represents an initialization collision.  */
 static sctp_disposition_t sctp_sf_do_dupcook_b(const sctp_endpoint_t *ep,
 					       const sctp_association_t *asoc,
 					       sctp_chunk_t *chunk,
diff -ur 2.5.63a/sound/core/seq/seq_midi_emul.c 2.5.63b/sound/core/seq/seq_midi_emul.c
--- 2.5.63a/sound/core/seq/seq_midi_emul.c	Mon Feb 24 11:05:44 2003
+++ 2.5.63b/sound/core/seq/seq_midi_emul.c	Mon Feb 24 17:56:45 2003
@@ -375,7 +375,7 @@
 
 
 /*
- * intialize the MIDI status
+ * initialize the MIDI status
  */
 void
 snd_midi_channel_set_clear(snd_midi_channel_set_t *chset)
diff -ur 2.5.63a/sound/oss/awe_wave.c 2.5.63b/sound/oss/awe_wave.c
--- 2.5.63a/sound/oss/awe_wave.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/sound/oss/awe_wave.c	Mon Feb 24 17:56:47 2003
@@ -562,7 +562,7 @@
 	/* clear all samples */
 	awe_reset_samples();
 
-	/* intialize AWE32 hardware */
+	/* initialize AWE32 hardware */
 	awe_initialize();
 
 	sprintf(awe_info.name, "AWE32-%s (RAM%dk)",
diff -ur 2.5.63a/sound/oss/es1371.c 2.5.63b/sound/oss/es1371.c
--- 2.5.63a/sound/oss/es1371.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/sound/oss/es1371.c	Mon Feb 24 17:56:49 2003
@@ -2863,7 +2863,7 @@
 	if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1))<0 ))
 		goto err_dev4;
 #ifdef ES1371_DEBUG
-	/* intialize the debug proc device */
+	/* initialize the debug proc device */
 	s->ps = create_proc_read_entry("es1371",0,NULL,proc_es1371_dump,NULL);
 #endif /* ES1371_DEBUG */
 	
diff -ur 2.5.63a/sound/oss/ite8172.c 2.5.63b/sound/oss/ite8172.c
--- 2.5.63a/sound/oss/ite8172.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/sound/oss/ite8172.c	Mon Feb 24 17:56:51 2003
@@ -1780,7 +1780,7 @@
 	goto err_dev2;
 
 #ifdef IT8172_DEBUG
-    /* intialize the debug proc device */
+    /* initialize the debug proc device */
     s->ps = create_proc_read_entry(IT8172_MODULE_NAME, 0, NULL,
 				   proc_it8172_dump, NULL);
 #endif /* IT8172_DEBUG */
diff -ur 2.5.63a/sound/oss/nec_vrc5477.c 2.5.63b/sound/oss/nec_vrc5477.c
--- 2.5.63a/sound/oss/nec_vrc5477.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/sound/oss/nec_vrc5477.c	Mon Feb 24 17:56:53 2003
@@ -1884,7 +1884,7 @@
 		goto err_dev2;
 
 #ifdef VRC5477_AC97_DEBUG
-	/* intialize the debug proc device */
+	/* initialize the debug proc device */
 	s->ps = create_proc_read_entry(VRC5477_AC97_MODULE_NAME, 0, NULL,
 				       proc_vrc5477_ac97_dump, NULL);
 #endif /* VRC5477_AC97_DEBUG */
diff -ur 2.5.63a/sound/usb/usbaudio.c 2.5.63b/sound/usb/usbaudio.c
--- 2.5.63a/sound/usb/usbaudio.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/sound/usb/usbaudio.c	Mon Feb 24 17:56:55 2003
@@ -1717,7 +1717,7 @@
 
 
 /*
- * intialize the substream instance.
+ * initialize the substream instance.
  */
 
 static void init_substream(snd_usb_stream_t *as, int stream, struct audioformat *fp)
