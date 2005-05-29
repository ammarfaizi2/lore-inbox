Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVE2VxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVE2VxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVE2VxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:53:23 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:51957 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVE2VxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:53:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:from;
        b=kTVpPOnkF8rAOkZ/++z8VrhhGFbNtD8BvPCKbA1Mv8jsqdMuWoqkTLY9rjeT7eJZ2+PWMzxC9FumbUmGReghqO4WMKcHMGDsSn4gxY7oEDYNpb4CjLR/uJpBPlWDFvOgO6ouAmVvD1lwbNPMmwz+BDCNJ6SEwFTZL7QTLgEIPSw=
Message-ID: <429A39BF.3020005@gmail.com>
Date: Sun, 29 May 2005 23:53:03 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: linux mailing-list <linux-kernel@vger.kernel.org>, jeremy@goop.org
Subject: Re: CPUFREQ/speedstep on Intel 955X chipset based system
References: <429A07EF.6090905@gmail.com> <429A14C3.20604@tiscali.de>
In-Reply-To: <429A14C3.20604@tiscali.de>
Content-Type: multipart/mixed;
 boundary="------------050609050706050708080900"
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050609050706050708080900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Matthias-Christian Ott schrieb:

> Michael Thonke wrote:
>
>> Hello,
>>
>> I recently bought an Asus P5WAD2 motherboard which uses the Intel 955x
>> chipset.
>> I noticed that CPUFREQ/speedsteps with the same kernel and same
>> config from
>> my system with Intel 925XE and Intel Pentium 640 does not work on the
>> system with
>> Intel 955X chipset (the processor is the same). In Windows it works
>> perfectly on 925XE
>> and 955X chipset.
>> The kernels I used
>>
>> 2.6.12-rc5 vanilla with git4 patch
>> 2.6.12-rc5-mm1.
>>
>> I attached the output of dmesg and `cat /proc/cpuinfo`
>>
> Please turn on cpufreq debugging (see Documentation/ for details) and
> post the output.
>
>> Thanks in advance
>>
>> Best regards
>>     Michael
>> [ ... ]
>
>
> Matthias-Christian Ott
>
Hello,

the debug infos show following when I try to modprobe speedstep-centrino.

    speedstep-centrino: Invalid control/status registers (1 - 1)
    speedstep-centrino: <6>speedstep-centrino: invalid ACPI data
    speedstep-centrino: <6>speedstep-centrino: found unsupported CPU
    with Enhanced SpeedStep: send /proc/cpuinfo to Jeremy Fitzhardinge
    <jeremy@goop.org>
    speedstep-centrino: Invalid control/status registers (1 - 1)
    speedstep-centrino: <6>speedstep-centrino: invalid ACPI data

cpuinfo follows

/Michael



--------------050609050706050708080900
Content-Type: text/plain;
 name="cpuinfo.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo.out"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 3
cpu MHz		: 3211.542
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6340.60
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 3
cpu MHz		: 3211.542
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6406.14
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:


--------------050609050706050708080900--
