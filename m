Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVBHUKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVBHUKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVBHUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:08:52 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:15198 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S261652AbVBHUIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:08:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: BIOS Bug
Date: Tue, 8 Feb 2005 12:08:19 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301B3D548@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BIOS Bug
Thread-Index: AcUN2jTAxwhLEd6yRXiBPn2dWESA6QAPzdfg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <DOSProfi@web.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Feb 2005 20:08:20.0822 (UTC) FILETIME=[EFB07F60:01C50E19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>-----Original Message-----
>>>From: linux-kernel-owner@vger.kernel.org 
>>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Enrico Bartky
>>>Sent: Monday, February 07, 2005 7:12 AM
>>>To: linux-kernel@vger.kernel.org
>>>Subject: BIOS Bug
>>>
>>>Hello,
>>>
>>>on my notebook, when I plugged in my USB keyboard the kernel 
>>>doesnt boot correctly, ...
>>>
>>>... 
>>>BIOS hangoff failed ( 112, 1010001 )
>>>continuing after BIOS bug
>>>irq 192, pci mem 0xfebff000
>>>new usb device registered, assigned bus number 1
>>>...
>>>
>>>then the notebook hangs. If I boot without the plugged 
>>>keyboard and plug in when the kernel is ready, there are no 
>>>problems. I have a SiS USB chipset.
>>>
>>>Can you help me?
>>>    
>>>
>>
>>What kernel version are you using ?
>>Try 2.6.10 with the following command line parameter:
>>usb-handoff
>>
>>Aleks.
>>  
>>
>Thanx, it works! Can you say me,  it is really a BIOS Bug, a 
>buggy ACPI 
>or a driver problem?

It depends. But I believe in your case it is just too late 
for hand off in USB driver. Try search for usb handoff in this 
list.

Aleks.
