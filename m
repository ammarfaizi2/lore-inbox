Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTKRQ4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTKRQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:56:09 -0500
Received: from web40903.mail.yahoo.com ([66.218.78.200]:50021 "HELO
	web40903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263705AbTKRQ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:56:06 -0500
Message-ID: <20031118165605.39280.qmail@web40903.mail.yahoo.com>
Date: Tue, 18 Nov 2003 08:56:05 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: AW: HT enable on BIOS which doesn't supports it?
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 18 Nov 2003 17:07:29 +0100, "Michal Semler (volny.cz)" said:
> > Hmm..so why "ht" flag is detected?
> >
> > This chip is really strange. It looks like only renamed real P4/XEON,
> > coz through CPUFREQ I got it to work on lower frequencies:
> 
> Not really. Here's mine (Dell Latitude C840):
> 
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 15
> model : 2
> model name : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
> stepping : 4
> cpu MHz : 1595.776
> ....
> flags : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush
> dts acpi mmx fxsr sse sse2 ss ht tm
> 
> Wow.. HT-enabled. However, if I build an SMP-enabled kernel, it turns out that
> there's only one sibling...

My CPU is like that too:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping        : 7
cpu MHz         : 1994.259
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3932.16

I also have an 'ht' flag -- but I've never tried SMP. XP doesn't seem to think HT
is on here either, so I just put it down as an anomaly.

Brad

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
