Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCWVfW>; Sat, 23 Mar 2002 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCWVfM>; Sat, 23 Mar 2002 16:35:12 -0500
Received: from elin.scali.no ([62.70.89.10]:1540 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291102AbSCWVfH>;
	Sat, 23 Mar 2002 16:35:07 -0500
Date: Sat, 23 Mar 2002 22:34:57 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: Janos Farkas <chexum@shadow.banki.hu>
cc: Banai Zoltan <bazooka@enclavenet.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: io-apic not working on i850mv(p4)
In-Reply-To: <priv$1016911429.lord@lk8rp.mail.xeon.eu.org>
Message-ID: <Pine.LNX.4.30.0203232232240.11080-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Janos Farkas wrote:

> 2002-03-23, 18:17: Banai Zoltan szerint:
> > I have an Intel i850MV motherboard with:
> ...
> > model name	: Intel(R) Pentium(R) 4 CPU 1.70GHz
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> ...
> > using 2.4.19-pre3-ac3 kernel with IO-APIC, but it seems not working to me:
> >   0:    5420792          XT-PIC  timer
> ...
> > why gives XT-PIC instead of IO-APIC for all interrupst
>
> Because you don't have an IO APIC?
>
> > Found and enabled local APIC!
> ...
> > Using local APIC timer interrupts.
> > calibrating APIC timer ...
> ...
>
> I/O APIC != local APIC; the latter is on on all CPU's since P5 (at least
> for Intel), I/O APIC's are usable mostly on SMP boards.  Is yours SMP
> capable?
>

I don't think so, i850 & P4 is not SMP capable (Only P4 Xeon is). Maybe
the kernel config is missing CONFIG_X86_UP_IOAPIC ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

