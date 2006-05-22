Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEVMTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEVMTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWEVMTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:19:50 -0400
Received: from euklides.vdsoft.org ([82.208.56.17]:22759 "EHLO
	euklides.vdsoft.org") by vger.kernel.org with ESMTP
	id S1750790AbWEVMTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:19:49 -0400
Message-ID: <4471AC63.8060406@vdsoft.org>
Date: Mon, 22 May 2006 14:19:47 +0200
From: Vladimir Dvorak <dvorakv@vdsoft.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPUx
References: <44716A5F.3070208@vdsoft.org> <p73k68e71kd.fsf@verdi.suse.de> <4471A777.2020404@vdsoft.org> <200605221403.16464.ak@suse.de>
In-Reply-To: <200605221403.16464.ak@suse.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Monday 22 May 2006 13:58, Vladimir Dvorak wrote:
>  
>
>>Andi Kleen wrote:
>>
>>    
>>
>>>Vladimir Dvorak <dvorakv@vdsoft.org> writes:
>>> 
>>>
>>>      
>>>
>>>>Linux requisities:
>>>>Debian 3.1
>>>>Linux mailserver 2.6.8-3-686-smp #1 SMP Thu Feb 9 07:05:39 UTC 2006 i686
>>>>   
>>>>
>>>>        
>>>>
>>>That's an ancient kernel.
>>> 
>>>
>>>      
>>>
>>Yes, I agree.
>>
>> ... but the latest in Debian/Sarge. :-)
>>
>>Do you, Andi,  thing that upgrade to latest vanilla one ( from
>>kernel.org ) should solve this problem ?
>>    
>>
>
>Probably not.
>
>  
>
>>> 
>>>
>>>      
>>>
>>>>GNU/Linux
>>>>
>>>>Hardware:
>>>>Intel SR1200
>>>>   
>>>>
>>>>        
>>>>
>>>If it's an <=P3 class machine: most likely you have noise on the APIC bus.
>>>
>>>-Andi
>>>
>>> 
>>>
>>>      
>>>
>>Yes, you are right :
>>
>>cat /proc/cpuinfo
>>...
>>model name      : Intel(R) Pentium(R) III CPU family      1133MHz
>>...
>>
>>
>>"Noise on APIC bus" means - " a lot of interrupts from devices" ?
>>    
>>
>
>Usually a crappy/broken/misdesigned motherboard.
>
>-Andi
> 
>
>  
>
And, probably, the latest question related to this topic:

Can "noapic" or "nolapic" solve this ? Does it mean ( with these
parameters ) that devices will start to use 8259 interrupt controller
instead APIC ?

Is harmfull put "noapic" on "nolapic" to cmdline ?

Thank you.

Vladimir

