Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSHVIBi>; Thu, 22 Aug 2002 04:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSHVIBi>; Thu, 22 Aug 2002 04:01:38 -0400
Received: from cibs9.sns.it ([192.167.206.29]:33293 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S318014AbSHVIBh>;
	Thu, 22 Aug 2002 04:01:37 -0400
Date: Thu, 22 Aug 2002 10:05:24 +0200 (CEST)
From: venom@sns.it
To: Banai Zoltan <bazooka@emitel.hu>
cc: Kelsey Hudson <khudson@compendium.us>,
       James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <20020821215503.GC1669@bazooka.saturnus.vein.hu>
Message-ID: <Pine.LNX.4.43.0208221004310.7650-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Banai Zoltan wrote:

> Date: Wed, 21 Aug 2002 23:55:03 +0200
> From: Banai Zoltan <bazooka@emitel.hu>
> To: Kelsey Hudson <khudson@compendium.us>
> Cc: James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
>      "Reed, Timothy A" <timothy.a.reed@lmco.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Hyperthreading
>
> On Wed, Aug 21, 2002 at 02:16:11PM -0700, Kelsey Hudson wrote:
> > On Wed, 21 Aug 2002, James Bourne wrote:
> >
> > > On Wed, 21 Aug 2002, Hugh Dickins wrote:
> > >
> > > > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > > > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > > > just appropriate to that processor in other ways.
> > >
> > > I was under the impression that the only CPU capable of hyperthreading was
> > > the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
> > > have the ht feature.
> >
> > This is currently correct, although I believe Intel has plans to release a
> > Hyperthreading-capable version of its desktop P4.
>
> If this is correct, and there is not destop P4 capable of ht,
> then what does mean the ht flag in cpuinfo?
>
> $cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 1
> model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
> stepping        : 2
> cpu MHz         : 1694.907
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 3381.65
>                                                          ^^
In fact all PIV are capable of ht, but usually there is way to enable due
to bioses and similar



