Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030914AbWKUMjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030914AbWKUMjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030915AbWKUMjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:39:53 -0500
Received: from smtp-02.mandic.com.br ([200.225.81.133]:3744 "EHLO
	smtp-02.mandic.com.br") by vger.kernel.org with ESMTP
	id S1030914AbWKUMjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:39:52 -0500
Message-ID: <4562F38F.8010404@mandic.com.br>
Date: Tue, 21 Nov 2006 10:39:43 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ahci] Failed with error -12
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I receive this error message on boot with Kernel 2.6.18.3

relevant (I think) dmesg output:
=======
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level,
low) -> IRQ 11
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1100 irq 14
scsi0 : ata_piix
========

# hwinfo --disk
23: IDE 00.0: 10600 Disk
  [Created at block.191]
  UDI: /org/freedesktop/Hal/devices/storage_serial_75QW2718S
  Unique ID: mE25.WkVGlyavV53
  Parent ID: w7Y8.owfwZLxeTg6
  SysFS ID: /block/sda
  SysFS BusID: 0:0:0:0
  SysFS Device Link:
/devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0
  Hardware Class: disk
  Model: "TOSHIBA MK1032GA"
  Vendor: "TOSHIBA"
  Device: "MK1032GA"
  Revision: "AB21"
  Serial ID: "75QW2718S"
  Driver: "ata_piix", "sd"
  Device File: /dev/sda
  Device Files: /dev/sda,
/dev/disk/by-id/scsi-SATA_TOSHIBA_MK1032G_75QW2718S
  Device Number: block 8:0-8:15
  BIOS id: 0x80
  Geometry (Logical): CHS 12161/255/63
  Size: 195371568 sectors a 512 bytes
  Config Status: cfg=no, avail=yes, need=no, active=unknown
  Attached to: #16 (IDE interface)

Best regards,
- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFYvOO41FQMNQgUVoRAuMsAJ4u1LyPkzwzPDIodVBJlPNi9r1JQACfYDTN
LS8v5Gkofy0OZUmiABCxXHE=
=ndQX
-----END PGP SIGNATURE-----
