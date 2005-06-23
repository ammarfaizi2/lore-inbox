Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVFWNWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVFWNWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVFWNWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:22:14 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:37893 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S262216AbVFWNRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:17:24 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAA7D@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'Sean Bruno'" <sean.bruno@dsl-only.net>,
       "Hodle, Brian" <BHodle@harcroschem.com>
Cc: "'peter@pantasys.com'" <peter@pantasys.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: CK804 APIC and PCI Express to PCI Bridge problems
Date: Thu, 23 Jun 2005 08:12:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,
  Sorry for the two messages, but as I was looking at your dmesg I noticed
the line the kills my PC when I enable ACPI APIC in my BIOS:

ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
AE_NOT_FOUND
search_node ffff810140008240 start_node ffff810140008240 return_node
0000000000000000
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
AE_NOT_FOUND
search_node ffff810140008140 start_node ffff810140008140 return_node
0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
AE_NOT_FOUND
search_node ffff810140008140 start_node ffff810140008140 return_node
0000000000000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node
ffff810140008100), AE_NOT_FOUND

Directly after the preceeding my puter hangs. (unless ACPI is disabled)

-Brian

-----Original Message-----
From: Sean Bruno [mailto:sean.bruno@dsl-only.net]
Sent: Wednesday, June 22, 2005 10:17 PM
To: Hodle, Brian
Cc: 'peter@pantasys.com'; 'linux-kernel@vger.kernel.org'
Subject: Re: CK804 APIC and PCI Express to PCI Bridge problems


On Wed, 2005-06-22 at 20:24 -0500, Hodle, Brian wrote:
> PCI: Cannot allocate resource region 0 of device 0000:02:00.0
> PCI: Cannot allocate resource region 3 of device 0000:04:00.0
> PCI: Failed to allocate mem resource #3:1000000@fc000000 for
> 0000:04:00.0

Wow! this looks real familiar<grin>.

Here is my machine's dmesg output as well.

BTW, Brian, what arguments are u passing to the kernel at boot time?

