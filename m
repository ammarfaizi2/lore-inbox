Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbSLRUO2>; Wed, 18 Dec 2002 15:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbSLRUO1>; Wed, 18 Dec 2002 15:14:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2188 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267466AbSLRUOY>; Wed, 18 Dec 2002 15:14:24 -0500
Date: Wed, 18 Dec 2002 15:25:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Terje Eggestad <terje.eggestad@scali.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3E00D716.1010503@transmeta.com>
Message-ID: <Pine.LNX.3.95.1021218152425.806A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1168719212-1040243110=:806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1168719212-1040243110=:806
Content-Type: TEXT/PLAIN; charset=US-ASCII


The number of CPU clocks necessary to make the 'far' or
full-pointer call by pushing the segment register, the offset,
then issuing a 'lret' is 33 clocks on a Pentium II.
 
longcall clocks = 46
call clocks = 13
actual full-pointer call clocks = 33

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.573
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.573
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


--1678434306-1168719212-1040243110=:806
Content-Type: APPLICATION/octet-stream; name="sysenter.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1021218152510.806B@chaos.analogic.com>
Content-Description: 

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
AAA=
--1678434306-1168719212-1040243110=:806--
