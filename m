Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSITH33>; Fri, 20 Sep 2002 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSITH33>; Fri, 20 Sep 2002 03:29:29 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:22815 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S261238AbSITH31>; Fri, 20 Sep 2002 03:29:27 -0400
Date: Fri, 20 Sep 2002 09:34:28 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.36 &  AIC-7XXXX
Message-ID: <Pine.LNX.4.44.0209200910070.17802-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

AIC7XXX on kernel 2.5.36 not working. I can't boot system on this kernel.


[root@xxx ]# lspci  
00:00.0 Host bridge: Intel Corp. e7500 DRAM Controller (rev 03)
00:00.1 Class ff00: Intel Corp. e7500 DRAM Controller Error Reporting (rev 
03)
00:03.0 PCI bridge: Intel Corp. e7500 HI_C Virtual PCI-to-PCI Bridge (F0) 
(rev 03)
00:03.1 Class ff00: Intel Corp. e7500 HI_C Virtual PCI-to-PCI Bridge (F1) 
(rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
03:07.0 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
03:07.1 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
04:07.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
04:07.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
[...]
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000

(dmesg from 2.4.20-pre7)
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAM3367MC         Rev: 0106


-- 
*[ £ukasz Tr±biñski ]*


