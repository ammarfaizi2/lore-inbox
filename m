Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270662AbUJUB3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270662AbUJUB3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270583AbUJUBZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:25:13 -0400
Received: from baikonur.stro.at ([213.239.196.228]:64156 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S270512AbUJUBTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:19:06 -0400
Date: Thu, 21 Oct 2004 03:18:59 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.9-kjt1 patchset
Message-ID: <20041021011859.GA1933@stro.at>
Mail-Followup-To: kj <kernel-janitors@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many patches got merged these days thanks to Andrew.
module version by Luiz Capitulino.
Nishanth Aravamudan has more msleep conversions.

the bonus of this release are nice pci patches by Hanna Linder.
Greg takes care of them, but they got sent to kj, so one place
more testing them wont hurt. ;-)
as always reviews welcome!

here the patch (against current snapshot):
http://debian.stro.at/kjt/2.6.9-kjt1/2.6.9-bk4-kjt1.patch.bz2

splitted out patches
(if your patch is inside please check):
http://debian.stro.at/kjt/2.6.9-kjt1/split/

adds the kjt string now thanks to localversion.
a++ maks


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.9-rc2-kjt1

add-for_each_pci_dev.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [Patch 2.6] resend of macro to go through all pci devices

add_module_version-drivers_net_8139cp.patch
  From: Felipe W Damasio <felipewd@terra.com.br>
  Subject: [Kernel-janitors] [PATCH] 8139cp net driver: add MODULE_VERSION

for-each-pci-dev-arch_i386_pci_acpi.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6][2/54] arch/i386/pci/acpi.c Use 	for_each_pci_dev macro

for-each-pci-dev-arch_i386_pci_i386.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] [1/54] arch/i386/pci/i386.c: Use new 	for_each_pci_dev macro

for-each-pci-dev-arch_ppc64_kernel_iSeries_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [PATCH 2.6] iSeries_pci.c use for_each_pci_dev()

for-each-pci-dev-arch_ppc64_kernel_pmac_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [PATCH 2.6] pmac_pci.c replace pci_find_device with 	pci_get_device

for-each-pci-dev-arch_ppc64_kernel_pSeries_iommu.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] Re: [PATCH 2.6] pSeries_iommu.c use for_each_pci_dev()

for-each-pci-dev-arch_ppc64_kernel_pSeries_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [PATCH 2.6] pSeries_pci.c use for_each_pci_dev()

for-each-pci-dev-arch_ppc64_kernel_u3_iommu.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [PATCH 2.6] u3_iommu.c use for_each_pci_dev()

for-each-pci-dev-arch_sh_drivers_pci_fixups-dreamcast.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [PATCH 2.6] fixups-dreamcast.c use for_each_pci_dev()

for-each-pci-dev-drivers_char_agp_generic.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] generic.c: replace pci_find_device with 	pci_get_device

for-each-pci-dev-drivers_char_agp_isoch.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] isoch.c: replace pci_find_device with pci_get_device

for-each-pci-dev-drivers_char_agp_sis-agp.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] sis-agp.c: replace pci_find_device with 	pci_get_device

function-string-arch-mips.patch
  From: Clemens Buchacher <drizzd@aon.at>
  Subject: [Kernel-janitors] [PATCH] __FUNCTION__ string concatenation 	deprecated

modern-init-drivers_atm_zatm.patch
  From: Francois Romieu <romieu@fr.zoreil.com>
  Subject: [KJ] Re: [PATCH 2.6] zatm.c: replace pci_find_device with 	pci_get_device

module-version-drivers_usb_serial_belkin_sa.patch
  From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
  Subject: [Kernel-janitors] [PATCH 3/3] - Module version info for Belkin_sa.

module-version-drivers_usb_serial_cyberjack.patch
  From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
  Subject: [Kernel-janitors] [PATCH 2/3] - Module version info for CyberJack.

module-version-drivers_usb_serial_pl2303.patch
  From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
  Subject: [Kernel-janitors] [PATCH 1/3] - Module version info for PL2303.

msleep-drivers_media_radio_radio-zoltrix.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2] media/radio-zoltrix: replace 	sleep_delay() with msleep()

msleep-drivers_net_3c505.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/40] net/3c505: replace 	schedule_timeout() with msleep()

msleep-drivers_net_e1000_e1000_osdep.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 10/38] net/e1000_osdep: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_act200l-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/40] net/act2001-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_irtty-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 16/38] net/irtty-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_ma600-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 23/38] net/ma600-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_pcmcia_xirc2ps_cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 36/38] net/xirc2ps_cs: replace 	Wait() with msleep()

msleep-drivers_net_irda_pcmcia_yenta_socket.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/5] pcmcia/yenta_socket: 	replace schedule_timeout() with msleep()

msleep-drivers_net_irda_sir_dev.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 31/38] net/sir_dev: replace 	schedule_timeout() with msleep()

msleep-drivers_net_ixgb_ixgb_osdep.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 20/38] net/ixgb_osdep: replace 	schedule_timeout() with msleep()

msleep-drivers_net_ni65.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 25/38] net/ni65: replace 	schedule_timeout() with msleep()

msleep-drivers_net_ns83820.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 27/38] net/ns83820: replace 	schedule_timeout() with msleep()

msleep-drivers_net_s2io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 29/38] net/s2io: replace 	schedule_timeout() with msleep()

msleep-drivers_net_tulip_de2104x.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/38] net/de2104x: replace 	schedule_timeout() with msleep()

msleep-drivers_net_wan_cosa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/38] net/cosa: replace 	schedule_timeout() with msleep_interruptible()

msleep-drivers_net_wireless_prism54_islpci_dev.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 17/38] net/islpci_dev: replace 	schedule_timeout() with msleep()

msleep-drivers_net_wireless_prism54_islpci_mgt.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 18/38] net/islpci_mgt: add 	set_current_state() before schedule_timeout()

msleep-drivers_scsi_ibmvscsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/16] scsi/ibmvscsi: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_ide-scsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/16] scsi/ide-scsi: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_imm.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/16] scsi/imm: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_osst.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 7/16] scsi/osst: replace 	schedule_timeout() with msleep_interruptible()

msleep-drivers_scsi_ppa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/16] scsi/ppa: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_qla1280.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 9/16] scsi/qla1280: replace 	schedule_timeout() with msleep()

msleep-drivers_serial_pmac_zilog.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/6] serial/pmac_zilog: replace 	schedule_timeout() with msleep()

msleep_interruptible-drivers_net_cs89x0.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 6/38] net/cs89x0: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_net_e1000_e1000_ethtool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 9/38] net/e1000_ethtool: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_net_gt96100eth.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 14/38] net/g96100eth: replace 	gt96100_delay() with msleep_interruptible()

msleep_interruptible-drivers_net_irda_tekram-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 34/38] net/tekram-sir: replace 	schedule_timeout() with msleep()

msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 19/38] net/ixgb_ethtool: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_net_pcnet32.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 28/38] net/pcnet32: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_net_sb1000.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 30/38] net/sb1000: replace 	nicedelay() with msleep_interruptible()

msleep_interruptible-drivers_net_slip.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 32/38] net/slip: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_net_wan_cycx_drv.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 7/38] net/cycx_drv: replace 	delay_cycx() with msleep_interruptible()

msleep_interruptible-drivers_parport_ieee1284_ops.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/3] parport/ieee1284_ops: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_parport_ieee1284.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/3] parport/ieee1284: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_parport_parport_pc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/3] parport/parport_pc: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_pnp_pnpbios_core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2] pnpbios/core: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_s390_net_ctctty.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2] s390/ctctty: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_sbus_char_aurora.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] Re: sbus/aurora: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_sbus_char_envctrl.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/4] sbus/envctrl: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_scsi_53c700.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/16] scsi/53c700: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_scsi_dpt_i2o.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/16] scsi/dpt_i2o: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_scsi_scsi_lib.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 13/16] scsi/scsi_lib: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_scsi_st.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 15/16] scsi/st: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_serial_68328serial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/6] serial/68328serial: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_serial_68360serial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/6] serial/68360serial: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_serial_mcfserial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/6] serial/mcfserial: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_tc_zs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2] tc/zs: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_usb_media_dausb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/9] usb/dabusb: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_usb_misc_tiglusb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/9] usb/tiglusb: replace 	schedule_timeout() with msleep_interruptible()

msleep+msleep_interruptible-drivers_net_e100.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 11/38] net/e100: replace 	schedule_timeout() with msleep()/msleep_interruptible()

msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 15/38] net/ibmtr: replace 	schedule_timeout() with msleep()/msleep_interruptible()

msleep+msleep_interruptible-drivers_net_wireless_airo.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/40] net/airo: replace 	schedule_timeout() with msleep()/msleep_interuptible()

msleep+msleep_interruptible-drivers_serial_serial_core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 6/6] serial/serial_core: replace 	schedule_timeout() with msleep()/msleep_interruptible()

msleep+ssleep-drivers_net_appletalk_ltpc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 22/38] net/ltpc: replace 	schedule_timeout() with ssleep()/msleep()

pci_dev_present-arch_ia64_hp_common_sba_iommu.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 sba_iommu.c] Replace 	pci_find_device with pci_get_device

pci_dev_present-arch_ia64_pci_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 ia64/pci/pci.c] Replace 	pci_find_device with pci_get_device

pci_dev_present-arch-pci-irq.patch
  From: Greg KH <greg@kroah.com>
  Subject: [Kernel-janitors] Re: Create new function to see if pci dev is 	present

pci_dev_present-drivers_char_watchdoc_scx200_wdt.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 scx200_wdt.c] [1/8] Patch to 	replace pci_find_device with pci_dev_present

pci_dev_present-drivers_ide_ide.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 ide.c] [2/8] Patch to 	replace pci_find_device with pci_dev_present

pci_dev_present-drivers_ide_pci_alim15x3.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 alim15x3.c] [3/8] Replace 	pci_find_device with pci_dev_present

pci_dev_present-drivers_media_video_bttv-driver.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] 	convert pci_find_device to pci_dev_present

pci_dev_present-drivers_pci_hotplug_ibmphp_core.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 ibmphp_core.c][6/8] replace 	pci_get_device with pci_dev_present

pci_dev_present-drivers_video_matrox_matroxfb_base.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 matroxfb_base.c][7/8] 	Replace pci_find_device with pci_dev_present

pci_dev_present-sound_pci_cmipci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 cmipci.c] [8/8] Replace 	pci_find_device with pci_dev_present

pci_get_device-drivers_char_agp_amd64-agp.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] amd64-agp.c replace pci_find_device with 	pci_get_device

pci_get_device-drivers_char_agp_intel-agp.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] intel-agp.c: replace pci_find_device with 	pci_get_device

pci_get_device-drivers_char_agp_intel-mch-agp.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] intel-mch-agp.c: replace pci_find_device with 	pci_get_device

remove-custom-msleep-drivers_serial_icom.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/6] serial/icom: remove custom 	msleep()

remove-pci-find-device-arch_m68k_atari_hades-pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] hades-pci.c: replace pci_find_device 	with pci_get_device

remove-pci-find-device-arch_mips_pci_pci-hplj.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] pci-hplj.c: replace pci_find_device 	with pci_get_device

remove-pci-find-device-arch_ppc_platforms_chrp_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] [2/12] chrp_pci.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_gemini_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] [3/12] gemini_pci.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_lopec.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] [4/12] lopec.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_mcpn765.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6] [6/12] mcpn765.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_pcore.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6][7/12] pcore.c replace pci_find_device 	with pci_get_device

remove-pci-find-device-arch_ppc_platforms_pmac_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6][8/12] pmac_pci.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_pplus.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] Re: [Kernel-janitors] [PATCH 2.6][9/12] pplus.c 	replace	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_prep_pci.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] Re: [Kernel-janitors] [PATCH 2.6][10/12] prep_pci.c 	replace	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_prpmc750.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6][11/12] prpmc750.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_ppc_platforms_sandpoint.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6][12/12] sandpoint.c replace 	pci_find_device with pci_get_device

remove-pci-find-device-arch_sparc64_kernel_ebus.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] ebus.c replace pci_find_device with pci_get_device

remove-pci-find-device-arch_sparc64_kernel_pci_iommu.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] pci_iommu.c replace pci_find_device with 	pci_get_device

remove-pci-find-device-arch_sparc_kernel_ebus.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: Re: [KJ] [RFT 2.6] ebus.c replace pci_find_device with	pci_get_device

remove-pci-find-device-arch_x86_64_kernel_pci-gart.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [KJ] [RFT 2.6] pci-gart.c replace pci_find_device with 	pci_get_device

remove-pci-find-device-drivers_net_e1000_e1000_main.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 1/6] janitor: net/e1000: remove 	pci_find_device

remove-pci-find-device-drivers_net_gt96100eth.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 2/6] janitor: net/gt96100eth: 	pci_find_device to pci_get_device

remove-pci-find-device-drivers_net_ixgb_ixgb_main.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 3/6] janitor: net/ixgb: remove 	pci_find_device

remove-pci-find-device-drivers_net_sis900.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 4/6] janitor: net/sis900: pci_find_device 	to pci_get_device

remove-pci-find-device-drivers_net_tg3.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 5/6] janitor: net/tg3: pci_find_device to 	pci_dev_present

remove-pci-find-device-drivers_net_tulip_tulip_core.patch
  From: Scott Feldman <sfeldma@pobox.com>
  Subject: [Kernel-janitors] [PATCH 6/6] janitor: net/tulip: pci_find_device 	to pci_dev_present

remove-useless-pci-check-drivers_media_video_zr36120.patch
  From: Hanna Linder <hannal@us.ibm.com>
  Subject: [Kernel-janitors] Re: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert 	pci_find_device	to pci_dev_present

set_current_state-drivers_net_irda_stir4200.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 33/38] net/stir4200: replace 	direct assignment with set_current_state()

set_current_state-drivers_net_tokenring_tms380tr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 35/38] net/tms380tr: replace 	direct assignment with set_current_state()

set_current_state-drivers_net_wan_farsync.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 13/38] net/farsync: add 	set_current_state() before schedule_timeout()

ssleep-drivers_net_wireless_orinoco_plx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 26/38] net/orinoco_plx: replace 	schedule_timeout() with ssleep()

ssleep-drivers_net_wireless_orinoco_tmd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 27/38] net/orinoco_tmd: replace 	schedule_timeout() with ssleep()

ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 21/38] net/lanstreamer: replace 	schedule_timeout() with ssleep()/msleep_interruptible()





~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 merged 127 patches in linus current:

fix-check_region-esp.patch
fix-typo-arm-dma.patch
fix-units-drivers_isdn_icn.patch
function-string-arch_mips_au1000_db1x00_mirage_ts.patch
list-for-each-arch_alpha_kernel_pci.patch
list-for-each-arch_i386_pci_i386.patch
list-for-each-arch_ia64_pci_pci.patch
list-for-each-arch_ppc64_kernel_pci_dn.patch
list-for-each-arch_ppc64_kernel_pci.patch
list-for-each-arch_ppc_kernel_pci.patch
list-for-each-arch_sparc_kernel_pcic.patch
list-for-each-drivers_char_drm_radeon_mem.patch
list-for-each-drivers_pci_setup-bus2.patch
list-for-each-entry-drivers_atm_he.patch
list-for-each-entry-drivers_usb_class_audio.patch
list-for-each-entry-drivers_usb_class_usb-midi.patch
list-for-each-entry-drivers_usb_core_devices.patch
list-for-each-entry-drivers_usb_host_uhci-hcd.patch
list-for-each-entry-drivers_usb_media_dabusb.patch
list-for-each-entry-safe-drivers_usb_host_hc_sl811.patch
list-for-each-entry-safe-drivers_usb_serial_ipaq.patch
msleep-drivers_atm_firestream.patch
msleep-drivers_atm_he.patch
msleep-drivers_atm_idt77252.patch
msleep-drivers_atm_lanai.patch
msleep-drivers_char_rio_linux.patch
msleep-drivers_char_sis-agp.patch
msleep-drivers_isdn_hisax_config.patch
msleep-drivers_isdn_hisax_elsa.patch
msleep-drivers_isdn_hisax_hfc_pci.patch
msleep-drivers_isdn_hisax_hfcscard.patch
msleep-drivers_isdn_hisax_hfc_sx.patch
msleep-drivers_media_video_ovcamchip_ovcamchip_core.patch
msleep-drivers_media_video_zr36120.patch
msleep-drivers_net_wireless_airport.patch
msleep-drivers_pcmcia_cs.patch
msleep-drivers_pcmcia_ds.patch
msleep-drivers_pcmcia_i82365.patch
msleep-drivers_pcmcia_sa1100_h3600.patch
msleep-drivers_scsi_mesh.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_scsi_qla2xxx_qla_init.patch
msleep-drivers_scsi_qla2xxx_qla_os.patch
msleep-drivers_scsi_sata_sx4.patch
msleep-drivers_scsi_sd.patch
msleep-drivers_scsi_wd7000.patch
msleep_interruptible-drivers_char_amiserial.patch
msleep_interruptible-drivers_char_cyclades.patch
msleep_interruptible-drivers_char_dtlk.patch
msleep_interruptible-drivers_char_epca.patch
msleep_interruptible-drivers_char_esp.patch
msleep_interruptible-drivers_char_ftape-io.patch
msleep_interruptible-drivers_char_generic_serial.patch
msleep_interruptible-drivers_char_hvc_console.patch
msleep_interruptible-drivers_char_ip2main.patch
msleep_interruptible-drivers_char_isicom.patch
msleep_interruptible-drivers_char_istallion.patch
msleep_interruptible-drivers_char_lcd.patch
msleep_interruptible-drivers_char_moxa.patch
msleep_interruptible-drivers_char_mxser.patch
msleep_interruptible-drivers_char_pcxx.patch
msleep_interruptible-drivers_char_riscom8.patch
msleep_interruptible-drivers_char_rocket.patch
msleep_interruptible-drivers_char_serial167.patch
msleep_interruptible-drivers_char_specialix.patch
msleep_interruptible-drivers_char_stallion.patch
msleep_interruptible-drivers_char_synclink_cs.patch
msleep_interruptible-drivers_char_synclinkmp.patch
msleep_interruptible-drivers_char_synclink.patch
msleep_interruptible-drivers_char_tpqic02.patch
msleep_interruptible-drivers_char_zftape-buffers.patch
msleep_interruptible-drivers_i2c_busses_i2c-mpc.patch
msleep_interruptible-drivers_ieee1394_nodemgr.patch
msleep_interruptible-drivers_ieee1394_sbp2.patch
msleep_interruptible-drivers_isdn_act2000_isa_delay.patch
msleep_interruptible-drivers_isdn_capi_kcapi.patch
msleep_interruptible-drivers_isdn_hysdn_boardergo.patch
msleep_interruptible-drivers_isdn_hysdn_sched.patch
msleep_interruptible-drivers_isdn_icn.patch
msleep_interruptible-drivers_isdn_init.patch
msleep_interruptible-drivers_isdn_tty.patch
msleep_interruptible-drivers_macintosh_macserial.patch
msleep_interruptible-drivers_macintosh_therm_windtunnel.patch
msleep_interruptible-drivers_md_md.patch
msleep_interruptible-drivers_md_raid10.patch
msleep_interruptible-drivers_md_raid1.patch
msleep_interruptible-drivers_media_video_bw-qcam.patch
msleep_interruptible-drivers_media_video_cpia.patch
msleep_interruptible-drivers_media_video_c-qcam.patch
msleep_interruptible-drivers_media_video_planb.patch
msleep_interruptible-drivers_media_video_saa5249.patch
msleep_interruptible-drivers_media_video_tda9887.patch
msleep_interruptible-drivers_message_fusion_mptbase.patch
msleep_interruptible-drivers_message_i2o_exec-osm.patch
msleep_interruptible-drivers_mmc_mmc.patch
pr_debug-drivers_isdn_tpam.patch
pr_debug-i386_kernel_microcode.patch
remove-milliseconds-drivers_isdn_sc_hardware.patch
remove-old-ifdefs-aic79xx_core.patch
remove-old-ifdefs-aic79xx_inline.patch
remove-old-ifdefs-aic79xx_osm.c.patch
remove-old-ifdefs-aic79xx_osm.h.patch
remove-old-ifdefs-aic79xx_osm_pci.patch
remove-old-ifdefs-aic79xx.patch
remove-old-ifdefs-aic7xxx-cam.patch
remove-old-ifdefs-aic7xxx_core.patch
remove-old-ifdefs-aic7xxx_osm.c.patch
remove-old-ifdefs-aic7xxx_osm.h.patch
remove-old-ifdefs-aic7xxx.patch
remove-old-ifdefs-cpqarray.patch
remove-old-ifdefs-dmascc.patch
remove-old-ifdefs-fasttimer.patch
remove-unused-include-drivers_media_videocodec.patch
remove-unused-sleep-drivers_i2c_algos_i2c-algo-ite.patch
set_current_state-drivers_char_fdc-io.patch
set_current_state-drivers_char_ipmi_si_intf.patch
set_current_state-drivers_char_sx.patch
set_current_state-drivers_isdn_isdnloop.patch
set-current-state-drivers_usb_media_dabusb.patch
set-current-state-drivers_usb_misc_tiglusb.patch
ssleep-drivers_media_video_zoran_driver.patch
ssleep-drivers_message_i20_device.patch
static-bsd_comp.patch
static-ppp_deflate.patch
use-msecs-to-jiffies-drivers_video_aty_radeon_base.patch
use-msecs-to-jiffies-drivers_video_aty_radeonfb.patch
use-msecs-to-jiffies-isdn_sc_card.patch


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 dropped 40 patches:

list-for-each-arch_ia64_sn_io_machvec_pci_bus_cvlink.patch
file removed

list-for-each-arch_ppc64_kernel_pSeries_pci.patch
no longer needed

list_for_each-pcmcia-rsrc_mgr.patch
wrong
 
msleep-drivers_net_3c505.patch
msleep-drivers_net_appletalk_ltpc.patch
msleep-drivers_net_cs89x0.patch
msleep-drivers_net_e100.patch
msleep-drivers_net_e1000_osdep.patch
msleep-drivers_net_ewrk3.patch
msleep-drivers_net_gt96100eth.patch
msleep-drivers_net_irda_act200l-sir.patch
msleep-drivers_net_irda_irtty-sir.patch
msleep-drivers_net_irda_ma600-sir.patch
msleep-drivers_net_irda_sir_dev.patch
msleep-drivers_net_irda_tekram-sir.patch
msleep-drivers_net_ixgb_osdep.patch
msleep-drivers_net_max89x0.patch
msleep-drivers_net_ni65.patch
msleep-drivers_net_ns83820.patch
msleep-drivers_net_s2io.patch
msleep-drivers_net_slip.patch
msleep-drivers_net_tokenring_ibmtr.patch
msleep-drivers_net_tulip_de2104x.patch
msleep-drivers_net_wan_cosa.patch
msleep-drivers_net_wan_cycx_drv.patch
msleep-drivers_net_wireless_airo.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep-drivers_net_xirc2ps_cs.patch
msleep-drivers_parport_ieee1284_ops.patch
sleep-drivers_scsi_mesh.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_scsi_qla2xxx_qla_init.patch
msleep-drivers_scsi_qla2xxx_qla_os.patch
msleep-drivers_scsi_sd.patch
msleep-drivers_scsi_wd7000.patch
msleep-drivers_serial_pmac_zilog.patch
msleep-drivers_serial_serial_core.patch
set-current-state-net_wan_farsync.patch


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- split kernel_thread() patches from Walter Harms
- look at dprintk patches from Daniele Pizzoni

