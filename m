Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSHFWZI>; Tue, 6 Aug 2002 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSHFWZH>; Tue, 6 Aug 2002 18:25:07 -0400
Received: from jalon.able.es ([212.97.163.2]:28375 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316135AbSHFWZE>;
	Tue, 6 Aug 2002 18:25:04 -0400
Date: Wed, 7 Aug 2002 00:28:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Austin Gonyou <austin@digitalroadkill.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 See's incorrect cache size on P4 Xeons!?
Message-ID: <20020806222832.GA2733@werewolf.able.es>
References: <1028669517.6549.100.camel@UberGeek.coremetrics.com> <1028675096.18156.220.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1028675096.18156.220.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 07, 2002 at 01:04:56 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.07 Alan Cox wrote:
>
>> On boot each processor is says it has 1MB L3, is 2.4.19 unable to read
>> that or something?
>
>At the moment we report the L1/L2 - we don't actually go decoding L3
>caches. They are quite new. We should do however.
>

???

P4 Xeon 1.8:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 1.80GHz
stepping        : 4
cpu MHz         : 1784.295
cache size      : 512 KB   <================
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3565.15

Oops, model is different....

God save us from PC hardware manufacturers. A Xeon is not just a Xeon.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-jam0, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.2mdk)
