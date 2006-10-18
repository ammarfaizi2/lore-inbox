Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWJRRnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWJRRnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWJRRnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:43:40 -0400
Received: from 195-238-60-104.direcpceu.com ([195.238.60.104]:44232 "HELO
	internews.af") by vger.kernel.org with SMTP id S1751486AbWJRRnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:43:39 -0400
X-Spam-Check-By: internews.af
Subject: PCI quirk - Toshiba Satellite M55-S331 - 2.6.18-1.2200.fc5
From: Will Kemp <Will@Swaggie.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 18 Oct 2006 22:14:09 +0430
Message-Id: <1161193449.2904.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boot time kernel message:


PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) (try
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently


With 'pci=assign-busses', i get the following result:


PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29) interrupt mode.


Hardware: Toshiba Satellite M55-S331
Kernel: 2.6.18-1.2200.fc5

Please let me know if you want any more information.

Regards
Will




-- 
http://flickr.com/photos/willkemp
http://myspace.com/will_kemp

