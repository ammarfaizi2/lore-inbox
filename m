Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTDUPfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDUPfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:35:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:18110 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261334AbTDUPfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:35:20 -0400
Date: Mon, 21 Apr 2003 08:47:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 615] New: lots of "irq 5: nobody cared!n" on boot
Message-ID: <28620000.1050940041@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=615

           Summary: lots of "irq 5: nobody cared!n" on boot
    Kernel Version: 2.5.68-bk1
            Status: NEW
          Severity: low
             Owner: ambx1@neo.rr.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: 
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X
(rev  c)
02:0a.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
02:0b.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)

Software Environment:
# CONFIG_ACPI is not set
# CONFIG_APM is not set
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y


Problem Description:
On boot, I'm getting lots of debug-looking messages:

Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
irq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5:
nobody car ed!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody  cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: no body cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5 : nobody cared!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: nobody cared!ni rq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5: nobody care d!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nob ody cared!nirq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5:  nobody
cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nir q
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared !nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq
5: nobody c ared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobo dy cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq  5: nobody cared!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: nobody cared! nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5: nobody ca red!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobod y cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: n obody cared!nirq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!n irq
5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody car
ed!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5:
nobody  cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: no body cared!nirq 5: nobody cared!nirq 5: nobody cared!nirq
5: nobody cared!nirq 5 : nobody cared!nirq 5: nobody cared!nirq 5: nobody
cared!nirq 5: nobody cared!ni rq 5: nobody cared!n<6>isapnp: Card 'SYM
53C416'
isapnp: Card 'CS4236B'
isapnp: 2 Plug & Play cards detected total

BTW, system later oops in Vortex init, with a vortex_interrupt oops when
the  NIC starts.. maybe its related?

Steps to reproduce:


