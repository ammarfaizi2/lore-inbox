Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTEJRxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTEJRxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:53:46 -0400
Received: from bay2-f72.bay2.hotmail.com ([65.54.247.72]:51462 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264461AbTEJRxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:53:43 -0400
X-Originating-IP: [24.190.68.159]
X-Originating-Email: [daracerz@hotmail.com]
From: "Mark F." <daracerz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Bug] 2.5.69 - Cisco PCM352 (Aironet 350/352 PCMCIA) Card Driver Failure
Date: Sat, 10 May 2003 14:06:14 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F72HPQuAJrfDzN0000bda9@hotmail.com>
X-OriginalArrivalTime: 10 May 2003 18:06:14.0437 (UTC) FILETIME=[D872DD50:01C3171E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Simply, I can't get the card to work and really ain't asking for help, but 
mearly Bug Reporting.  The problem is probably related at either the PCMCIA 
Controller or the Cisco Driver.

Description:  I boot the computer with the Network Card Plugged in the 
PCMCIA Port Already.   When the Kernel Boots,  my Card Initializes a Puts 
Out the Orange/Red Looking Light On Non Stop which according to Cisco 
Indicates Incorrect Driver.    Then later on the boot process, it tries to 
reset the card, and then both my Green and Orange Led's Are Light Non Stop.  
Green is Status, Activity is Orange/Red.

Heres are Some Lines I took out of the Logs of the Activities with the 
Network Card.
>From Kernel:
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
PCI: Enabling device 00:0a.0 (0000 -> 0002)
Yenta IRQ list 0c98, PCI irq5
Socket status: 30000010

>From  System:
May 10 13:26:26 localhost kernel: airo:  Probing for PCI adapters
May 10 13:26:26 localhost cardmgr[1085]: could not adjust resource: IO ports 
0x100-0x4ff: Device or resource busy
May 10 13:26:26 localhost cardmgr[1085]: could not adjust resource: memory 
0xc0000-0xfffff: Input/output error
May 10 13:26:26 localhost cardmgr[1085]: could not adjust resource: memory 
0xa0000000-0xa0ffffff: Input/output error
May 10 13:26:26 localhost cardmgr[1085]: could not adjust resource: IO ports 
0xa00-0xaff: Device or resource busy
May 10 13:26:26 localhost kernel: airo:  Finished probing for PCI adapters
May 10 13:26:27 localhost kernel: Yenta IRQ list 0c98, PCI irq5
May 10 13:26:27 localhost kernel: Socket status: 30000010
May 10 13:26:28 localhost kernel: cs: IO port probe 0x0c00-0x0cff: clean.
May 10 13:26:28 localhost kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x200-0x207 0x220-0x22f 0x2f8-0x2ff 0x330-0x337 0x388-0x38f 0x3c0-0x3df 
0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
May 10 13:26:28 localhost kernel: cs: IO port probe 0x0a00-0x0aff: clean.
May 10 13:26:28 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: 
clean.
May 10 13:26:28 localhost kernel: eth0: link up, 10Mbps, half-duplex, lpa 
0x0000
May 10 13:26:27 localhost acpid: acpid startup succeeded
May 10 13:26:28 localhost kernel: airo: Max tries exceeded waiting for 
command
May 10 13:26:28 localhost kernel: airo: MAC could not be enabled
May 10 13:26:28 localhost kernel: airo_cs: RequestConfiguration: Operation 
succeeded
May 10 13:26:29 localhost cardmgr[1085]: get dev info on socket 0 failed: 
Resource temporarily unavailable


System Specifications:
Red Hat 9.0 Backed System (With Some RPM RawHide Updates, Specifically 
Modutils)
Compaq 900Z - Radeon IGP 320M

Will Send Any Other Needed Information

Mark

Please CC Messages to daracerz@hotmail.com

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

