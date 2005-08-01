Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVHAR0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVHAR0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVHAR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 13:26:53 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:33918 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261302AbVHAR0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 13:26:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.13-rc4-mm1
Date: Mon, 1 Aug 2005 10:26:51 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C341E3FA@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-rc4-mm1
thread-index: AcWV0WOENEV64iLMTLG+Jk1xsweZvgA7KzNg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Michael Thonke" <iogl64nx@gmail.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Aug 2005 17:26:52.0482 (UTC) FILETIME=[34DDA220:01C596BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Michael Thonke
>Sent: Sunday, July 31, 2005 8:12 AM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: 2.6.13-rc4-mm1
>
>Hello Andrew,
>
>the ACPI bug or the problems with 2.6.13-rc3-mm[2,3] gone.
>The system boots now noiseless, except on problem with USB.
>
>If my Prolific USB-Serialadapter  plugged in on reboot
>the ehci_hcd driver complains about a Hand-off bug in Bios.
>
>-> snip
>
>ehci_hcd 0000:00:1d.7: EHCI Host Controller
>
>ehci_hcd 0000:00:1d.7: debug port 1
>
>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 01010001)
>
>ehci_hcd 0000:00:1d.7: continuing after BIOS bug...
>
>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
>
>ehci_hcd 0000:00:1d.7: irq 161, io mem 0xd2dffc00
>
>-> snip
>
>
>I wonder about this because all other USB devices working without this 
>message on boot.
>
>USB Mouse,Keyboard and USB Storage and all mixed from USB 1.1 and 2.
>
>When I rebooted without plugged Prolific Adapter and plug them in the 
>same port
>the kernel prints this message.
>
>->snip
>
>usb 4-1: new full speed USB device using uhci_hcd and address 2
>
>pl2303 4-1:1.0: PL-2303 converter detected
>
>usb 4-1: PL-2303 converter now attached to ttyUSB0
>
>-> snip
>
>
>Any Ideas what could be wrong here?
>
Could you try 'usb-handoff' as a kernel parameter. Is it any better ?

Aleks.
