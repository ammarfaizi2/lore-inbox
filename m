Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTDDG6X (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDDG6W (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:58:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9140 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263465AbTDDG6L (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 01:58:11 -0500
Date: Thu, 03 Apr 2003 23:09:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 539] New: mouse hyper sensitive, and (almost) no 3-button emulation
Message-ID: <1560000.1049440171@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=539

           Summary: mouse hyper sensitive, and (almost) no 3-button
                    emulation
    Kernel Version: 2.5.66 with gcc 3.2.2
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: georgw@galis.org


Distribution:
RH 8.0 w/ updates

Hardware Environment:
Sony Vaio PCG-Z505LS, PIII,laptop integrated mouse
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio
Controller] (rev 02)
00:0a.0 Communication controller: Conexant HSF 56k Data/Fax Modem (Mob WorldW
SmartDAA) (rev 01)
00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x
(rev 64)

Software Environment:
XFree86 Version 4.2.0 (Red Hat Linux release: 4.2.0-72)
Mozilla/5.0 rv:1.0.1

Problem Description:
Under 2.5.66 mouse is too sensitive to work properly, okay when adjusted to
SLOWEST sensitivity/acceleration.

The (3 button emulated) center click works one out of 20 times in Mozilla.

Steps to reproduce:
uploaded the output of
(set -x;uname -a;cat /proc/cpuinfo;lspci;dmesg;cat
/usr/src/linux-2.5.66/.config)&>fait-2.5.66-info
here
http://galis.org/fait-2.5.66-info

Sorry, don't know how to catorgize this bug...

// George


