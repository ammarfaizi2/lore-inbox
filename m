Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWJRTRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWJRTRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWJRTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:17:24 -0400
Received: from av1.karneval.cz ([81.27.192.123]:2064 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161276AbWJRTRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:17:22 -0400
Message-ID: <453679D0.8060101@gmail.com>
Date: Wed, 18 Oct 2006 21:00:32 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: linux-acpi@vger.kernel.org
Subject: speedstep-centrino: ENODEV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

How is it possible to find out whether or not speedstep-centrino is supported. I 
have
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.60GHz
stepping        : 6
cpu MHz         : 1600.149
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat 
clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips        : 3201.52

processor, but speedstep-centrino returns ENODEV because of lack of _PCT et al 
entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). It is possible to 
hard-code that values to speedstep-centrino as for banias cpus or use corrected 
DSDT that will contain _PCT, _PSS and _PPC, but where may I obtain these values?

This is Asus M6R notebook, some DSDT parts of this piece of HW are really ugly 
(problems with acpi some time ago).

I may use p4-clockmod (and it points me to speedstep-centrino module), but if I 
am correct, it doesn't save battery life?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
