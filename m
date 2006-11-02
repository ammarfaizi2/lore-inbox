Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752466AbWKBBuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbWKBBuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbWKBBuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:50:20 -0500
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:678
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1752466AbWKBBuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:50:19 -0500
Message-ID: <45494ED9.6010402@seclark.us>
Date: Wed, 01 Nov 2006 20:50:17 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: Dave Jones <davej@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
References: <4548DDF4.2030903@seclark.us> <20061101201218.GA4899@martell.zuzino.mipt.ru> <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com> <4549450F.3080207@seclark.us>
In-Reply-To: <4549450F.3080207@seclark.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:

>Dave Jones wrote:
>
>  
>
>>On Wed, Nov 01, 2006 at 04:17:50PM -0500, Stephen Clark wrote:
>>
>>    
>>
>>>BIOS-provided physical RAM map:
>>> BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>>> BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
>>> BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>>> BIOS-e820: 000000001fff0000 - 000000001ffff000 (ACPI data)
>>> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
>>> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
>>>0MB HIGHMEM available.
>>>511MB LOWMEM available.
>>>Using x86 segment limits to approximate NX protection
>>>DMI 2.2 present.
>>>Using APIC driver default
>>>ACPI: PM-Timer IO Port: 0x8008
>>>Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
>>>Detected 850.075 MHz processor.
>>>Built 1 zonelists.  Total pages: 131056
>>>Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic nousb 
>>>console=ttyS0,38400
>>>Local APIC disabled by BIOS -- reenabling.
>>>Found and enabled local APIC!
>>>      
>>>
>>Does it make a difference if you boot with nolapic ?
>>
>>	Dave
>>
>> 
>>
>>    
>>
>Hi Dave,
>
>booting without lapic allowed it to boot but now I get
>...
>Local APIC disabled by BIOS -- you can enable it with "lapic"
>...
>Local APIC not detected. Using dummy APIC emulation.
>  which means more processor overhead - right?
>
>also cpuspeed doesn't work anymore - I don't have a cpufreq dir
>
>I don't get the following messages with kernel 2798
> powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
>Nov  1 19:33:34 joker4 kernel: powernow: SGTC: 10000
>Nov  1 19:33:34 joker4 kernel: powernow: Minimum speed 300 MHz. Maximum 
>speed 850 M
>Hz.
>Nov  1 19:33:34 joker4 kernel: powernow-k8: Processor cpuid 670 not 
>supported
>
>Steve
>
>
>
>  
>
I removed and reinstalled the kernel, it seems FC6 upgrade
installed a 586 kernel - now the only problem I have is my
local apic is not being used.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



