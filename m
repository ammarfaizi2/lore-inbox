Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTKRRIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKRRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:08:45 -0500
Received: from mout2.freenet.de ([194.97.50.155]:9654 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263723AbTKRRIk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:08:40 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: AW: HT enable on BIOS which doesn't supports it?
Date: Tue, 18 Nov 2003 18:08:23 +0100
User-Agent: KMail/1.5.93
References: <20031118165605.39280.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20031118165605.39280.qmail@web40903.mail.yahoo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311181808.37541.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 18 November 2003 17:56, Bradley Chapman wrote:
> My CPU is like that too:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
> stepping        : 7
> cpu MHz         : 1994.259
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 3932.16
> 
> I also have an 'ht' flag -- but I've never tried SMP. XP doesn't seem to
> think HT is on here either, so I just put it down as an anomaly.

All Northwood CPUs have ht, but it's disabled and you cannot use it.
(except you have an "official" HT-CPU 8-) )

mb@lfs:~> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping        : 4
cpu MHz         : 2240.925
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4423.68

> Brad

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ulIUoxoigfggmSgRAkerAJ9kIByapAADdKFTMNVtypsI6Lx4YgCfSnip
TnYSxhE+aKO6MbxKyEH+pNs=
=JBVd
-----END PGP SIGNATURE-----
