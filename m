Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTITPOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTITPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 11:14:37 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:19601 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261898AbTITPOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 11:14:35 -0400
Message-ID: <3F6C6F75.3020607@blue-labs.org>
Date: Sat, 20 Sep 2003 11:17:09 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hermes@gibson.dropbear.id.au
Subject: Problems w/ 2.6.0-test5 and orinocco device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short, I can bring up dev eth2 which is a wireless net card 
(orinocco), but if I bring it down, it breaks.  I can't do anything with 
it anymore; I have to reboot before I can use it again.  This didn't 
happen in -test4.  Once in a while in -test4 and below it did break but 
broke differently.  Mail me if you want details on it.

orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson 
<hermes@gibson.dropbear.id.au>)

eth2: Station identity 001f:0001:0008:000a
eth2: Looks like a Lucent/Agere firmware version 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:18:9F
eth2: Station name "HERMES I"
eth2: ready
eth2: index 0x01: Vcc 3.3, irq 9, io 0x0100-0x013f
eth2: New link status: Connected (0001)
spurious 8259A interrupt: IRQ7.
eth2: New link status: AP Out of Range (0004)
eth2: New link status: AP In Range (0005)


