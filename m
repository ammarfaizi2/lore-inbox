Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVAMLGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVAMLGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVAMLD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:03:56 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:19926 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S261563AbVAMKzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:55:54 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Old bug fixed few years ago newly interduced in 2.6.10
Date: Thu, 13 Jan 2005 11:55:37 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131155.37554.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

there were a bug when cpufreq and laptop started on battery, that linux 
thought system boots on higher frequecy then it really worked.

It is back now :((

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 3200.000
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
pse36 clflush dts acpi mmx fxsr sse sse2 ssht tm pbe cid xtpr
bogomips        : 6400.00

Thanks for fixing again :D

Michal
