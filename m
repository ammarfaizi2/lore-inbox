Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946260AbWBDBqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946260AbWBDBqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946262AbWBDBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:46:35 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:33898 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946260AbWBDBqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:46:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Iw3WOBARgso8fxUa4Mv37v9FlcNDpSmymcR240eP7uazLoPtbBeE72/JlNrN0Mi5uoFBLiDXTueiI2WZYhMtNn/cQBkkrLg26R/zgAAWZY4yTtvzwiWArxfyKtvG8Qs24ZHSzzJ1cRFZvX0KcX2oHOSud4SD4GWNUmwCEslA7TU=
Date: Sat, 4 Feb 2006 05:04:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] s/;;/;/g
Message-ID: <20060204020440.GB7837@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm/mach-pxa/leds-mainstone.c     |    6 +++---
 arch/arm/mach-s3c2410/cpu.c            |    2 +-
 arch/frv/kernel/gdb-stub.c             |    2 +-
 arch/ia64/sn/kernel/bte.c              |    2 +-
 arch/ia64/sn/pci/tioca_provider.c      |    2 +-
 arch/mips/mm/dma-ip32.c                |    6 +++---
 arch/ppc/syslib/ppc85xx_setup.c        |    2 +-
 arch/sparc64/kernel/irq.c              |    2 +-
 drivers/char/pcmcia/synclink_cs.c      |    2 +-
 drivers/char/synclink.c                |    2 +-
 drivers/char/synclink_gt.c             |    2 +-
 drivers/char/synclinkmp.c              |    2 +-
 drivers/hwmon/gl520sm.c                |    2 +-
 drivers/i2c/chips/rtc8564.c            |    2 +-
 drivers/ide/ide-dma.c                  |    2 +-
 drivers/net/sk98lin/skge.c             |    2 +-
 drivers/net/sky2.h                     |    2 +-
 drivers/net/wireless/prism54/oid_mgt.c |    4 ++--
 drivers/net/wireless/spectrum_cs.c     |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c  |    2 +-
 drivers/usb/image/microtek.c           |    2 +-
 drivers/usb/input/hid-core.c           |    2 +-
 drivers/video/aty/radeon_pm.c          |    2 +-
 fs/cifs/cifssmb.c                      |    2 +-
 fs/pnode.c                             |    2 +-
 include/acpi/acpi_bus.h                |    2 +-
 include/asm-ia64/sn/sn_sal.h           |    2 +-
 net/ipv4/inet_hashtables.c             |    2 +-
 net/ipv4/netfilter/ip_nat_standalone.c |    2 +-
 net/tipc/link.c                        |    2 +-
 sound/ppc/toonie.c                     |    4 ++--
 31 files changed, 37 insertions(+), 37 deletions(-)

--- a/arch/arm/mach-pxa/leds-mainstone.c
+++ b/arch/arm/mach-pxa/leds-mainstone.c
@@ -85,7 +85,7 @@ void mainstone_leds_event(led_event_t ev
 		break;
 
 	case led_green_on:
-		hw_led_state |= D21;;
+		hw_led_state |= D21;
 		break;
 
 	case led_green_off:
@@ -93,7 +93,7 @@ void mainstone_leds_event(led_event_t ev
 		break;
 
 	case led_amber_on:
-		hw_led_state |= D22;;
+		hw_led_state |= D22;
 		break;
 
 	case led_amber_off:
@@ -101,7 +101,7 @@ void mainstone_leds_event(led_event_t ev
 		break;
 
 	case led_red_on:
-		hw_led_state |= D23;;
+		hw_led_state |= D23;
 		break;
 
 	case led_red_off:
--- a/arch/arm/mach-s3c2410/cpu.c
+++ b/arch/arm/mach-s3c2410/cpu.c
@@ -146,7 +146,7 @@ void s3c24xx_set_board(struct s3c24xx_bo
 	board = b;
 
 	if (b->clocks_count != 0) {
-		struct clk **ptr = b->clocks;;
+		struct clk **ptr = b->clocks;
 
 		for (i = b->clocks_count; i > 0; i--, ptr++)
 			s3c24xx_register_clock(*ptr);
--- a/arch/frv/kernel/gdb-stub.c
+++ b/arch/frv/kernel/gdb-stub.c
@@ -1406,7 +1406,7 @@ void gdbstub(int sigval)
 			__debug_frame->psr |= PSR_S;
 		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
 		__debug_regs->brr |= BRR_EB;
-		sigval = SIGXCPU;;
+		sigval = SIGXCPU;
 	}
 
 	LEDS(0x5002);
--- a/arch/ia64/sn/kernel/bte.c
+++ b/arch/ia64/sn/kernel/bte.c
@@ -36,7 +36,7 @@ static struct bteinfo_s *bte_if_on_node(
 	nodepda_t *tmp_nodepda;
 
 	if (nasid_to_cnodeid(nasid) == -1)
-		return (struct bteinfo_s *)NULL;;
+		return (struct bteinfo_s *)NULL;
 
 	tmp_nodepda = NODEPDA(nasid_to_cnodeid(nasid));
 	return &tmp_nodepda->bte_if[interface];
--- a/arch/ia64/sn/pci/tioca_provider.c
+++ b/arch/ia64/sn/pci/tioca_provider.c
@@ -377,7 +377,7 @@ tioca_dma_mapped(struct pci_dev *pdev, u
 	struct tioca_dmamap *ca_dmamap;
 	void *map;
 	unsigned long flags;
-	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(pdev);;
+	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(pdev);
 
 	tioca_common = (struct tioca_common *)pcidev_info->pdi_pcibus_info;
 	tioca_kern = (struct tioca_kernel *)tioca_common->ca_kernel_private;
--- a/arch/mips/mm/dma-ip32.c
+++ b/arch/mips/mm/dma-ip32.c
@@ -138,7 +138,7 @@ dma_addr_t dma_map_single(struct device 
 		BUG();
 	}
 
-	addr = virt_to_phys(ptr)&RAM_OFFSET_MASK;;
+	addr = virt_to_phys(ptr)&RAM_OFFSET_MASK;
 	if(dev == NULL)
 	    addr+=CRIME_HI_MEM_BASE;
 	return (dma_addr_t)addr;
@@ -179,7 +179,7 @@ int dma_map_sg(struct device *dev, struc
 		addr = (unsigned long) page_address(sg->page)+sg->offset;
 		if (addr)
 			__dma_sync(addr, sg->length, direction);
-		addr = __pa(addr)&RAM_OFFSET_MASK;;
+		addr = __pa(addr)&RAM_OFFSET_MASK;
 		if(dev == NULL)
 			addr +=  CRIME_HI_MEM_BASE;
 		sg->dma_address = (dma_addr_t)addr;
@@ -199,7 +199,7 @@ dma_addr_t dma_map_page(struct device *d
 
 	addr = (unsigned long) page_address(page) + offset;
 	dma_cache_wback_inv(addr, size);
-	addr = __pa(addr)&RAM_OFFSET_MASK;;
+	addr = __pa(addr)&RAM_OFFSET_MASK;
 	if(dev == NULL)
 		addr +=  CRIME_HI_MEM_BASE;
 
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -237,7 +237,7 @@ mpc85xx_setup_pci2(struct pci_controller
 	   (__ilog2(MPC85XX_PCI2_UPPER_MEM - MPC85XX_PCI2_LOWER_MEM + 1) - 1);
 
 	/* Setup outbound IO windows @ MPC85XX_PCI2_IO_BASE */
-	pci->potar2 = (MPC85XX_PCI2_LOWER_IO >> 12) & 0x000fffff;;
+	pci->potar2 = (MPC85XX_PCI2_LOWER_IO >> 12) & 0x000fffff;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI2_IO_BASE >> 12) & 0x000fffff;
 	/* Enable, IO R/W */
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -646,7 +646,7 @@ void handler_irq(int irq, struct pt_regs
 }
 
 #ifdef CONFIG_BLK_DEV_FD
-extern irqreturn_t floppy_interrupt(int, void *, struct pt_regs *);;
+extern irqreturn_t floppy_interrupt(int, void *, struct pt_regs *);
 
 /* XXX No easy way to include asm/floppy.h XXX */
 extern unsigned char *pdma_vaddr;
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -4181,7 +4181,7 @@ static int hdlcdev_attach(struct net_dev
 	}
 
 	info->params.encoding = new_encoding;
-	info->params.crc_type = new_crctype;;
+	info->params.crc_type = new_crctype;
 
 	/* if network interface up, reprogram hardware */
 	if (info->netcount)
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -7770,7 +7770,7 @@ static int hdlcdev_attach(struct net_dev
 	}
 
 	info->params.encoding = new_encoding;
-	info->params.crc_type = new_crctype;;
+	info->params.crc_type = new_crctype;
 
 	/* if network interface up, reprogram hardware */
 	if (info->netcount)
--- a/drivers/char/synclink_gt.c
+++ b/drivers/char/synclink_gt.c
@@ -1365,7 +1365,7 @@ static int hdlcdev_attach(struct net_dev
 	}
 
 	info->params.encoding = new_encoding;
-	info->params.crc_type = new_crctype;;
+	info->params.crc_type = new_crctype;
 
 	/* if network interface up, reprogram hardware */
 	if (info->netcount)
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -1650,7 +1650,7 @@ static int hdlcdev_attach(struct net_dev
 	}
 
 	info->params.encoding = new_encoding;
-	info->params.crc_type = new_crctype;;
+	info->params.crc_type = new_crctype;
 
 	/* if network interface up, reprogram hardware */
 	if (info->netcount)
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -455,7 +455,7 @@ static ssize_t set_temp_max(struct i2c_c
 	long v = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->temp_max[n - 1] = TEMP_TO_REG(v);;
+	data->temp_max[n - 1] = TEMP_TO_REG(v);
 	gl520_write_value(client, reg, data->temp_max[n - 1]);
 	up(&data->update_lock);
 	return count;
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -53,7 +53,7 @@ static inline u8 _rtc8564_ctrl2(struct i
 #define CTRL1(c) _rtc8564_ctrl1(c)
 #define CTRL2(c) _rtc8564_ctrl2(c)
 
-static int debug;;
+static int debug;
 module_param(debug, int, S_IRUGO | S_IWUSR);
 
 static struct i2c_driver rtc8564_driver;
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -175,7 +175,7 @@ ide_startstop_t ide_dma_intr (ide_drive_
 			if (rq->rq_disk) {
 				ide_driver_t *drv;
 
-				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+				drv = *(ide_driver_t **)rq->rq_disk->private_data;
 				drv->end_request(drive, 1, rq->nr_sectors);
 			} else
 				ide_end_request(drive, 1, rq->nr_sectors);
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -1727,7 +1727,7 @@ struct sk_buff	*pMessage)	/* pointer to 
 		pTxd->VDataHigh = (SK_U32) (PhysAddr >> 32);
 		pTxd->pMBuf     = pMessage;
 		
-		pTxd->TBControl = Control | BMU_OWN | sk_frag->size;;
+		pTxd->TBControl = Control | BMU_OWN | sk_frag->size;
 
 		/* 
 		** Do we have the last fragment? 
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1768,7 +1768,7 @@ struct sky2_rx_le {
 	__le16	length;
 	u8	ctrl;
 	u8	opcode;
-} __attribute((packed));;
+} __attribute((packed));
 
 struct sky2_status_le {
 	__le32	status;	/* also checksum */
--- a/drivers/net/wireless/prism54/oid_mgt.c
+++ b/drivers/net/wireless/prism54/oid_mgt.c
@@ -332,7 +332,7 @@ mgt_le_to_cpu(int type, void *data)
 	case OID_TYPE_ATTACH:{
 			struct obj_attachment *attach = data;
 			attach->id = le16_to_cpu(attach->id);
-			attach->size = le16_to_cpu(attach->size);; 
+			attach->size = le16_to_cpu(attach->size); 
 			break;
 	}
 	case OID_TYPE_SSID:
@@ -401,7 +401,7 @@ mgt_cpu_to_le(int type, void *data)
 	case OID_TYPE_ATTACH:{
 			struct obj_attachment *attach = data;
 			attach->id = cpu_to_le16(attach->id);
-			attach->size = cpu_to_le16(attach->size);; 
+			attach->size = cpu_to_le16(attach->size); 
 			break;
 	}
 	case OID_TYPE_SSID:
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -147,7 +147,7 @@ struct pdi {
 	__le16 _len;		/* length of ID and data, in words */
 	__le16 _id;		/* record ID */
 	char data[0];		/* plug data */
-} __attribute__ ((packed));;
+} __attribute__ ((packed));
 
 
 /* Functions for access to little-endian data */
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -2797,7 +2797,7 @@ mbox_post_sync_cmd(adapter_t *adapter, u
 	// available within 1 second, assume FW is initializing and wait
 	// for an extended amount of time
 	if (mbox->numstatus == 0xFF) {	// status not yet available
-		udelay(25);;
+		udelay(25);
 
 		for (i = 0; mbox->numstatus == 0xFF && i < 1000; i++) {
 			rmb();
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -360,7 +360,7 @@ static int mts_scsi_host_reset (Scsi_Cmn
 	rc = usb_lock_device_for_reset(desc->usb_dev, desc->usb_intf);
 	if (rc < 0)
 		return FAILED;
-	result = usb_reset_device(desc->usb_dev);;
+	result = usb_reset_device(desc->usb_dev);
 	if (rc)
 		usb_unlock_device(desc->usb_dev);
 	return result ? FAILED : SUCCESS;
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1119,7 +1119,7 @@ static void hid_irq_out(struct urb *urb,
 
 	if (hid->outhead != hid->outtail) {
 		if (hid_submit_out(hid)) {
-			clear_bit(HID_OUT_RUNNING, &hid->iofl);;
+			clear_bit(HID_OUT_RUNNING, &hid->iofl);
 			wake_up(&hid->wait);
 		}
 		spin_unlock_irqrestore(&hid->outlock, flags);
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2080,7 +2080,7 @@ static void radeon_reinitialize_M9P(stru
 	OUTREG(0x2ec, 0x6332a3f0);
 	mdelay(17);
 
-	OUTPLL(pllPPLL_REF_DIV, rinfo->pll.ref_div);;
+	OUTPLL(pllPPLL_REF_DIV, rinfo->pll.ref_div);
 	OUTPLL(pllPPLL_DIV_0, rinfo->save_regs[92]);
 
 	mdelay(40);
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4907,7 +4907,7 @@ SetEARetry:
 	parm_data->list_len = cpu_to_le32(count);
 	parm_data->list[0].EA_flags = 0;
 	/* we checked above that name len is less than 255 */
-	parm_data->list[0].name_len = (__u8)name_len;;
+	parm_data->list[0].name_len = (__u8)name_len;
 	/* EA names are always ASCII */
 	if(ea_name)
 		strncpy(parm_data->list[0].name,ea_name,name_len);
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -130,7 +130,7 @@ static struct vfsmount *get_source(struc
 {
 	struct vfsmount *p_last_src = NULL;
 	struct vfsmount *p_last_dest = NULL;
-	*type = CL_PROPAGATION;;
+	*type = CL_PROPAGATION;
 
 	if (IS_MNT_SHARED(dest))
 		*type |= CL_MAKE_SHARED;
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -269,7 +269,7 @@ struct acpi_device_wakeup_state {
 
 struct acpi_device_wakeup {
 	acpi_handle gpe_device;
-	acpi_integer gpe_number;;
+	acpi_integer gpe_number;
 	acpi_integer sleep_state;
 	struct acpi_handle_list resources;
 	struct acpi_device_wakeup_state state;
--- a/include/asm-ia64/sn/sn_sal.h
+++ b/include/asm-ia64/sn/sn_sal.h
@@ -1037,7 +1037,7 @@ ia64_sn_get_sn_info(int fc, u8 *shubtype
 
 /***** BEGIN HACK - temp til old proms no longer supported ********/
 	if (ret_stuff.status == SALRET_NOT_IMPLEMENTED) {
-		int nasid = get_sapicid() & 0xfff;;
+		int nasid = get_sapicid() & 0xfff;
 #define SH_SHUB_ID_NODES_PER_BIT_MASK 0x001f000000000000UL
 #define SH_SHUB_ID_NODES_PER_BIT_SHFT 48
 		if (shubtype) *shubtype = 0;
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -315,7 +315,7 @@ ok:
  		spin_unlock(&head->lock);
 
  		if (tw) {
- 			inet_twsk_deschedule(tw, death_row);;
+ 			inet_twsk_deschedule(tw, death_row);
  			inet_twsk_put(tw);
  		}
 
--- a/net/ipv4/netfilter/ip_nat_standalone.c
+++ b/net/ipv4/netfilter/ip_nat_standalone.c
@@ -400,7 +400,7 @@ static int init_or_cleanup(int init)
 	ret = nf_register_hook(&ip_nat_local_out_ops);
 	if (ret < 0) {
 		printk("ip_nat_init: can't register local out hook.\n");
-		goto cleanup_adjustout_ops;;
+		goto cleanup_adjustout_ops;
 	}
 	ret = nf_register_hook(&ip_nat_local_in_ops);
 	if (ret < 0) {
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1629,7 +1629,7 @@ void tipc_link_retransmit(struct link *l
                                         tipc_msg_print(TIPC_CONS, buf_msg(buf), ">RETR>");
                                         info("...Retransmitted %u times\n",
 					     l_ptr->stale_count);
-                                        link_print(l_ptr, TIPC_CONS, "Resetting Link\n");;
+                                        link_print(l_ptr, TIPC_CONS, "Resetting Link\n");
                                         tipc_link_reset(l_ptr);
                                         break;
                                 }
--- a/sound/ppc/toonie.c
+++ b/sound/ppc/toonie.c
@@ -118,7 +118,7 @@ static int toonie_get_mute_switch(struct
 		gp = &mix->amp_mute_gpio;
 		break;
 	default:
-		return -EINVAL;;
+		return -EINVAL;
 	}
 	ucontrol->value.integer.value[0] = !check_audio_gpio(gp);
 	return 0;
@@ -146,7 +146,7 @@ static int toonie_put_mute_switch(struct
 		gp = &mix->amp_mute_gpio;
 		break;
 	default:
-		return -EINVAL;;
+		return -EINVAL;
 	}
 	val = ! check_audio_gpio(gp);
 	if (val != ucontrol->value.integer.value[0]) {

