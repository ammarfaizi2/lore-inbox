Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVH2S6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVH2S6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVH2S6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:58:01 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:64434 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S1751304AbVH2S6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:58:00 -0400
Date: Mon, 29 Aug 2005 20:56:22 +0200 (CEST)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists@free.fr>
X-X-Sender: peter@gaston.free.fr
To: linux-kernel@vger.kernel.org
Subject: kernel freezen with 2.6.12.5 and 2.6.13
Message-ID: <Pine.LNX.4.58.0508292050180.28621@gaston.free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
with 2.6.12.4 no problem. But with a newer version, I get a black screen
and no more network access, when trying to print (lpr some-file.ps).
Everything else seems to work ok.
Printer is a network-printer managed by cups.
I suppose, it's a smp-problem, so here is my /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.205
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5521.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.205
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5570.56


Let me know, if you need more information (for example my .config).

Kind regards, Peter

-- 
http://pmrb.free.fr/contact/
