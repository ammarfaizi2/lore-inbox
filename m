Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTKRQHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKRQHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:07:36 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:2315 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263590AbTKRQHc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:07:32 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Frank =?iso-8859-1?q?B=FCttner?= <frank-buettner@gmx.net>
Subject: Re: AW: HT enable on BIOS which doesn't supports it?
Date: Tue, 18 Nov 2003 17:07:29 +0100
User-Agent: KMail/1.5.4
References: <00e001c3adec$58762250$0200a8c0@netzvonfrank>
In-Reply-To: <00e001c3adec$58762250$0200a8c0@netzvonfrank>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311181707.29057.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm..so why "ht" flag is detected?

This chip is really strange. It looks like only renamed real P4/XEON,
coz through CPUFREQ I got it to work on lower frequencies:

cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 299.700
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 597.91

Can somebody tells me more? I would like start HT if it is possible

Michal

Dne úterý 18 listopad 2003 16:55 jste napsal(a):
> The Celeron is not a HT CPU!!!!
>
> -----Ursprüngliche Nachricht-----
> Von: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] Im Auftrag von Michal Semler
> (volny.cz)
> Gesendet: Dienstag, 18. November 2003 16:45
> An: linux-kernel@vger.kernel.org
> Betreff: HT enable on BIOS which doesn't supports it?
>
>
> Hi, in my laptop Acer TravelMate242 I have HT enabled CPU,
>
> but when I try start up with SMP or LocalAPIC kernel enabled, kernel
> freezes
>
> during boot time.
>
> Is there any possibility to run HT enabled CPU on my laptop without BIOS
> support?
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Celeron(R) CPU 2.40GHz
> stepping        : 9
> cpu MHz         : 2398.001
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 4784.12
>
> Thanks a lot
>
> Michal
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

