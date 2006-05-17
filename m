Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWEQORm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWEQORm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWEQORm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:17:42 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:48900 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932567AbWEQORl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:17:41 -0400
Message-ID: <446B3082.1000200@argo.co.il>
Date: Wed, 17 May 2006 17:17:38 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Joerg Pommnitz <pommnitz@yahoo.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wiretapping Linux?
References: <20060517132503.79272.qmail@web51410.mail.yahoo.com>
In-Reply-To: <20060517132503.79272.qmail@web51410.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2006 14:17:39.0481 (UTC) FILETIME=[A754E890:01C679BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Pommnitz wrote:
> --- Avi Kivity schrieb:
>   
>> A pci device can read system RAM and other memory-mapped PCI devices 
>> (such as display framebuffers) using DMA. In addition, a pci (but not 
>> pci-express) device can snoop on pci bus traffic to other devices. 
>> Typically, however, hard drive controllers will be integrated into the 
>> chipset so the data is not on the bus.
>>     
>
> Thanks for providing this information. This makes the binary firmware
> required for peripherals even more interesting for security conscious
> people.
>   

Note that some machines have IOMMUs so it may be possible to prevent a 
device from reading main memory, perhaps at a performance cost.

My AMD machine disables the IOMMU on startup.

If you don't trust your hardware there are only two solutions: keep it 
off the net or keep it off.

-- 
error compiling committee.c: too many arguments to function

