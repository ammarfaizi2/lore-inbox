Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVBHMfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVBHMfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVBHMeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:34:10 -0500
Received: from smtp08.web.de ([217.72.192.226]:44779 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261523AbVBHMcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:32:09 -0500
Message-ID: <4208B13F.8020802@web.de>
Date: Tue, 08 Feb 2005 13:31:59 +0100
From: Enrico Bartky <DOSProfi@web.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BIOS Bug
References: <5F106036E3D97448B673ED7AA8B2B6B301B3D393@scl-exch2k.phoenix.com>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B301B3D393@scl-exch2k.phoenix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov schrieb:

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Enrico Bartky
>>Sent: Monday, February 07, 2005 7:12 AM
>>To: linux-kernel@vger.kernel.org
>>Subject: BIOS Bug
>>
>>Hello,
>>
>>on my notebook, when I plugged in my USB keyboard the kernel 
>>doesnt boot correctly, ...
>>
>>... 
>>BIOS hangoff failed ( 112, 1010001 )
>>continuing after BIOS bug
>>irq 192, pci mem 0xfebff000
>>new usb device registered, assigned bus number 1
>>...
>>
>>then the notebook hangs. If I boot without the plugged 
>>keyboard and plug in when the kernel is ready, there are no 
>>problems. I have a SiS USB chipset.
>>
>>Can you help me?
>>    
>>
>
>What kernel version are you using ?
>Try 2.6.10 with the following command line parameter:
>usb-handoff
>
>Aleks.
>  
>
Thanx, it works! Can you say me,  it is really a BIOS Bug, a buggy ACPI 
or a driver problem?
