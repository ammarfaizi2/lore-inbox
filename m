Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVHKRLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVHKRLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVHKRLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:11:06 -0400
Received: from spirit.analogic.com ([208.224.221.4]:45064 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751129AbVHKRLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:11:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <2cd57c9005081109597b18cc54@mail.gmail.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> <1123770661.17269.59.camel@localhost.localdomain> <2cd57c90050811081374d7c4ef@mail.gmail.com> <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> <1123775508.17269.64.camel@localhost.localdomain> <1123777184.17269.67.camel@localhost.localdomain> <2cd57c90050811093112a57982@mail.gmail.com> <2cd57c9005081109597b18cc54@mail.gmail.com>
X-OriginalArrivalTime: 11 Aug 2005 17:11:04.0022 (UTC) FILETIME=[A7AB9F60:01C59E97]
Content-class: urn:content-classes:message
Subject: Re: Need help in understanding x86 syscall
Date: Thu, 11 Aug 2005 13:10:44 -0400
Message-ID: <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in understanding x86 syscall
Thread-Index: AcWel6e3N0YWU31sTWqi83vFy17c7g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Coywolf Qi Hunt" <coywolf@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, <7eggert@gmx.de>,
       "Ukil a" <ukil_a@yahoo.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Coywolf Qi Hunt wrote:

> On 8/12/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>> On 8/12/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> On Thu, 2005-08-11 at 11:51 -0400, Steven Rostedt wrote:
>>>>
>>>> And booted it.  The system is up and running, so I really don't think
>>>> that the sysenter_entry is used for system calls.
>>>>
>>>> Not so "Clear as day"!
>>>
>>> And so, looking into sysenter_entry, it seems that my configurations
>>> don't seem to use it. This jumps straight to system_call without ever
>>> having to turn interrupts on.
>>>
>>> # cat /proc/cpuinfo
>>> processor       : 0
>>> vendor_id       : GenuineIntel
>>> cpu family      : 6
>>> model           : 8
>>> model name      : Pentium III (Coppermine)
>>> stepping        : 3
>>> cpu MHz         : 367.939
>>> cache size      : 256 KB
>>> fdiv_bug        : no
>>> hlt_bug         : no
>>> f00f_bug        : no
>>> coma_bug        : no
>>> fpu             : yes
>>> fpu_exception   : yes
>>> cpuid level     : 2
>>> wp              : yes
>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>>> mca cmov pat pse36 mmx fxsr sse
>>> bogomips        : 722.94
>>>
>>>
>>> -- Steve
>>>
>>
>> The cpu does have sep. Is it vanilla kernel?
>>
>
> Also glibc support.
>
> --
> Coywolf Qi Hunt
> http://ahbl.org/~coywolf/

Probably doesn't use int 0x80 at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
