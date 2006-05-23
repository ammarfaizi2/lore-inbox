Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWEWHAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWEWHAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWEWHAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:00:50 -0400
Received: from odin2.bull.net ([129.184.85.11]:5839 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932068AbWEWHAt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:00:49 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RT patch + LTTng
Date: Tue, 23 May 2006 09:02:12 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
References: <200605221742.29566.Serge.Noiraud@bull.net> <1148341150.2556.99.camel@mindpipe>
In-Reply-To: <1148341150.2556.99.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605230902.12469.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 23 Mai 2006 01:39, Lee Revell wrote/a écrit :
> On Mon, 2006-05-22 at 17:42 +0200, Serge Noiraud wrote:
> > Hi,
> > 
> > 	I have added the LTTng patch to the 2.6.16-rt23.
> > In the LTT trace, I see some odd time stamps :
> 
> Is your test machine a dual core AMD64?
NO.
-sh-2.05b# more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.60GHz
stepping        : 1
cpu MHz         : 3600.494
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni mo
nitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7203.68

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.60GHz
stepping        : 1
cpu MHz         : 3600.494
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni mo
nitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7199.36

-sh-2.05b#

> 
> Lee
> 

-- 
Serge Noiraud
