Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268125AbUHQG5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268125AbUHQG5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268123AbUHQG5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:57:47 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:27476 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268125AbUHQG53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:57:29 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: bjorn.helgaas@hp.com
Subject: 2.6.8.1-mm1 broke USB driver with ACPI pci irq routing... info follows
Date: Tue, 17 Aug 2004 02:57:20 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QxaIB/YUAb3A4go"
Message-Id: <200408170257.26712.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QxaIB/YUAb3A4go
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


here is the lspci info. If I enable pci=routeirq the driver loads fine.

Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBIaxSsX/SQXZigqcRAqLAAJ9sA5kzCWg7EG3MwEcgo9qQ7IjcUQCeM4Kz
l7F3kjEODcXFiQAdet1LxTg=
=1LP/
-----END PGP SIGNATURE-----

--Boundary-00=_QxaIB/YUAb3A4go
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.dump"

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
0000:02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
0000:02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
0000:02:02.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)

--Boundary-00=_QxaIB/YUAb3A4go--
