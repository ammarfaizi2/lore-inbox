Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbTHZFX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTHZFX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:23:56 -0400
Received: from moth.netsolus.com ([65.16.30.101]:640 "EHLO moth")
	by vger.kernel.org with ESMTP id S262618AbTHZFXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:23:54 -0400
Subject: Interesting problem with 450NX based Compaq server
From: Bryan Ballard <ballard@netsolus.com>
To: linux-kernel@vger.kernel.org
Message-Id: <1061875433.24196.15.camel@ant>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Aug 2003 00:23:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I've looked through the kernel list archives and haven't found
anything that might help. I have a Compaq 5500r 4x500mhz Xeons and
whenever a heavy load is placed on the box it reboots without any kernel
panics or oops. It seems to be related primarily to multiple PCI card
access, i.e. during heavy RAID card / NIC interaction. I've tried to
isolate it by replacing NICs and RAID cards, but the only thing I can
come up with is that it is related to the 450NX chipset. 
Since I am not sure anyone is still working on the 450NX chipset I've
refrained from cluttering the list with a giant E-mail full of /proc
data until someone answers back that they would be interested in any
information that I can provide them.

Please CC me since I am not a list subscriber. 
Thanks in advance.

	Bryan Ballard

output of lspci:

00:02.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev
01)
00:0c.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
14)
00:0d.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
14)
00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a)
00:0f.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:0f.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:0f.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:0f.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:10.0 Host bridge: Intel Corp. 450NX - 82451NX Memory & I/O Controller
(rev 03)
00:12.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
Bridge (rev 04)
00:13.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
Bridge (rev 04)
04:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
04:05.0 PCI bridge: IBM IBM27-82351 (rev 01)
05:00.0 Unknown mass storage controller: Compaq Computer Corporation
Smart-2/P RAID Controller (rev 02)




   

