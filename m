Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWHNQCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWHNQCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWHNQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:02:29 -0400
Received: from spirit.analogic.com ([204.178.40.4]:11524 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751484AbWHNQC3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:02:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 14 Aug 2006 16:02:26.0823 (UTC) FILETIME=[09A4E970:01C6BFBB]
Content-class: urn:content-classes:message
Subject: Re: HT not active
Date: Mon, 14 Aug 2006 12:02:26 -0400
Message-ID: <Pine.LNX.4.61.0608141159270.21503@chaos.analogic.com>
In-Reply-To: <20060814153209.GB13641@csclub.uwaterloo.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not active
thread-index: Aca/uwmsq3ynEl+XSey3i72pt0C+dw==
References: <fa.YLv8m2Uw0It/GRKxQHnEfBS+Dao@ifi.uio.no> <44E08769.7010000@shaw.ca> <Pine.LNX.4.61.0608141035240.21276@chaos.analogic.com> <20060814153209.GB13641@csclub.uwaterloo.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2006, Lennart Sorensen wrote:

> On Mon, Aug 14, 2006 at 10:51:47AM -0400, linux-os (Dick Johnson) wrote:
>> It's mostly a motherboard issue. This board is an Intel motherboard.
>> However, Intel decided to not allow HT (strange). I tried to
>> bring the MB back to CompUSA, but they declared; "The board is
>> not defective. Windows doesn't use hyper threading, and this is
>> a windows-only board...." They claim no board is compatible with
>> Linux. They were perfectly willing to give me back my money, but
>> they would not guarantee that any of their motherboards were
>> "compatible" with Linux. With an attitude like that, one can
>> quickly learn where not to buy motherboards.
>
> It is both a motherboard (bios actually) and cpu issue.
>
>> processor	: 0
>> vendor_id	: GenuineIntel
>> cpu family	: 15
>> model		: 2
>> model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
>> stepping	: 7
>> cpu MHz		: 2794.381
>> cache size	: 512 KB
>> fdiv_bug	: no
>> hlt_bug		: no
>> f00f_bug	: no
>> coma_bug	: no
>> fpu		: yes
>> fpu_exception	: yes
>> cpuid level	: 2
>> wp		: yes
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>> bogomips	: 5592.62
>
> I have a P4 2.8GHz which does do HT.  It is family 15, model 2, stepping
> 9.  Stepping 7 is probably from just before intel started enabling HT
> support.  The P4A Northwood did not have HT and came in 1.6 to 2.8GHz
> (400FSB).  The P4B Northwood did have HT on the 3.06Ghz model only and
> came in 2.0 to 3.06Ghz (533FSB).  The P4C Northwood had HT and came
> in 2.4 to 3.4GHz (800FSB).  I have the P4C 2.8GHz which is showing as
> model 2 stepping 9.
>
>> The solution may be, in the future, to bring a bootable CR/ROM with you
>> when buying motherboards or CPUs.... and get stuff off the net that's
>> guaranteed to do what you want. This exact same software, exact same
>> configuration ".config" file, produces this on another machine:
>
> Who wants to buy a power wasting P4 now, when they can instead get the
> Core 2 or an Athlon 64 which run faster using less power?

They are now pretty cheap in the USA. Being obsolete by a year
or so gets some good performance at the additional electrical
cost of a nightlight!

>
>> processor	: 0
>> vendor_id	: GenuineIntel
>> cpu family	: 15
>> model		: 2
>> model name	: Intel(R) Xeon(TM) CPU 2.40GHz
>> stepping	: 9
>> cpu MHz		: 2399.779
>> cache size	: 512 KB
>> physical id	: 0
>> siblings	: 2
>> core id		: 0
>> cpu cores	: 1
>> fdiv_bug	: no
>> hlt_bug		: no
>> f00f_bug	: no
>> coma_bug	: no
>> fpu		: yes
>> fpu_exception	: yes
>> cpuid level	: 2
>> wp		: yes
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>> bogomips	: 4804.62
>
> So this is a model 2 stepping 9 just as my P4 is and HT works just like
> my P4 does.
>
> I can't actually find a list that says when stepping had what feature
> enabled.
>
> --
> Len Sorensen
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
