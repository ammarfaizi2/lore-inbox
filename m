Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVBHAYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVBHAYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVBHAYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:24:45 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:2146 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S261355AbVBHAYh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:24:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: BIOS Bug
Date: Mon, 7 Feb 2005 16:24:36 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301B3D393@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BIOS Bug
Thread-Index: AcUNJ7EcMmdhtUIoTOG7LFeFbPRE0AAS3yiQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Enrico Bartky" <DOSProfi@web.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Feb 2005 00:24:34.0684 (UTC) FILETIME=[90CFEBC0:01C50D74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Enrico Bartky
>Sent: Monday, February 07, 2005 7:12 AM
>To: linux-kernel@vger.kernel.org
>Subject: BIOS Bug
>
>Hello,
>
>on my notebook, when I plugged in my USB keyboard the kernel 
>doesnt boot correctly, ...
>
>... 
>BIOS hangoff failed ( 112, 1010001 )
>continuing after BIOS bug
>irq 192, pci mem 0xfebff000
>new usb device registered, assigned bus number 1
>...
>
>then the notebook hangs. If I boot without the plugged 
>keyboard and plug in when the kernel is ready, there are no 
>problems. I have a SiS USB chipset.
>
>Can you help me?

What kernel version are you using ?
Try 2.6.10 with the following command line parameter:
usb-handoff

Aleks.

>
>Thanx, EnricoB
>______________________________________________________________
>Verschicken Sie romantische, coole und witzige Bilder per SMS!
>Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
