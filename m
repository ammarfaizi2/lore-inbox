Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTJDXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTJDXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 19:25:16 -0400
Received: from fep03.swip.net ([130.244.199.131]:30975 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S262814AbTJDXZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 19:25:03 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: AIC-7901A not detected
Date: Sun, 5 Oct 2003 01:24:58 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Kb1f/madQKpXjUb"
Message-Id: <200310050124.58714.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Kb1f/madQKpXjUb
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I need to get working onboard integrated AIC-7901A RAID controller.

Can somebody help me??? Controller is not detected nor 2.4.23-pre6 kernel! :((
Debian Wooody with Bunk debs,

2 XEON P4 CPUs with HT enabled in BIOS
1GB RAM
3 SCSI HDDs Seegate Cheetah in RAID1
Adaptec AIC-7901a
Intel Server motherboard SE7501BR2

lspci:
00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
00:00.1 Class ff00: Intel Corp. E7000 Series Host RASUM Controller (rev 01)
00:03.0 PCI bridge: Intel Corp. E7000 Series Hub Interface C PCI-to-PCI Bridge 
(rev 01)
00:03.1 Class ff00: Intel Corp. E7000 Series Hub Interface C RASUM Controller 
(rev 01)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 
02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
01:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
01:04.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller 
(rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
03:03.0 RAID bus controller: Adaptec AIC-7901A U320 w/HostRAID (rev 03)

dmesg disks detecting part:
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
blk: queue c03ef3c0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=3649/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2

.config included


--Boundary-00=_Kb1f/madQKpXjUb
Content-Type: application/x-bzip2;
  name="config-experimental-XEON.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-experimental-XEON.bz2"

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

--Boundary-00=_Kb1f/madQKpXjUb--

