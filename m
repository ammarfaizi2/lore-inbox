Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271688AbTG2MkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTG2MkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:40:00 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:31714 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271688AbTG2Mj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:39:57 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>, <herbert@13thfloor.at>
Subject: RE: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Tue, 29 Jul 2003 08:51:19 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGKELACDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <m3u1962qir.fsf@defiant.pm.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa writes:

>Are you using some standard PCI bridge by chance? Are you sure it isn't
>a hardware (design or manufacturing) problem with the device (bridge)?

We are using the ASUS P4PE MoBo - Uses Intel 845PE chipset.  The message
file indicates:

Transparant bridge - Intel Corp. 82801BA/CA/DB PCI bridge

>How do you check interrupt request state?
I assume you are referring to the kernel debug stuff that I added?  The
routine I added simply read the Interrupt Mask Register (IMR), Interrupt
Request Register (IRR) and the Interrupt Service Register (ISR).  The IMR
shows that our IRQ is not masked off.  The IRR shows that there is currently
no interrupt pending for our IRQ.  The ISR shows that we are not currently
servicing our IRQ.

Regards,
Kathy


