Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTKYJoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTKYJoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:44:24 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:9375 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262190AbTKYJoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:44:22 -0500
Date: Tue, 25 Nov 2003 10:44:19 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: hyperthreading
Message-ID: <20031125094419.GB339@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: vega Linux 2.6.0-test9 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A somewhat stupid question from me, but I have no documentation about
this topic, namely, how can I enable hyperthreading with 2.6.0 test
kernels?

My /proc/cpuinfo shows:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1694.605
cache size      : 256 KB
[...]
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3334.14

I built kernel, with SMP, ACPI, APIC, etc etc etc support, but I don't see
any change. The only description I could find in Documentation/ is "acpi=ht"
about this topic saying that it's enabled enough ACPI just for enabling
HT. But I would like to have full ACPI and HT.

-- 
- Gábor (larta'H)
