Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263460AbSIUFjA>; Sat, 21 Sep 2002 01:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbSIUFjA>; Sat, 21 Sep 2002 01:39:00 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:8 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263460AbSIUFi7>; Sat, 21 Sep 2002 01:38:59 -0400
Date: Sat, 21 Sep 2002 07:43:27 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre-empt and smp in 2.5.37 - is it supposed to work? [contains 2 oopses, one in set_cpus_allowed, one in md code]
Message-ID: <20020921054327.GA667@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020920200441.GA3677@middle.of.nowhere> <1032552562.966.832.camel@phantasy> <20020920210225.GA526@middle.of.nowhere> <1032557366.2105.858.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032557366.2105.858.camel@phantasy>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@tech9.net>
Date: Fri, Sep 20, 2002 at 05:29:26PM -0400
> On Fri, 2002-09-20 at 17:02, Jurriaan wrote:
> 
> > 8139too Fast Ethernet driver 0.9.26
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000e
> > c024b6b9
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0060:[<c024b6b9>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010286
> > eax: 0000001e   ebx: fffffffa   ecx: c03675a8   edx: 00000292
> > esi: fffffffa   edi: ffffffea   ebp: 00002103   esp: f7737eec
> > ds: 0068   es: 0068   ss: 0068
> > Stack: 00002103 c024d562 fffffffa 00000931 00002103 00002103 00000000 c024dfd9 
> >        00002103 00000931 f7ca5e40 00002103 f77a3ee0 00000000 00000000 f778ba00 
> >        000061b0 00000001 00000000 00000006 00002103 00000000 00000000 00000000 
> > Call Trace: [<c024d562>] [<c024dfd9>] [<c014a826>] [<c0152d39>] [<c01071eb>] 
> > Code: 8b 43 14 85 c0 74 10 0f b7 50 10 b2 00 66 0f b6 40 10 09 c2 
> 
> What is this?  Do you normally see this?
> 
As a matter of fact, no. The second boot of 2.5.37 didn't oops at all -
perhaps I'll have better luck next reboot :-)

Jurriaan
-- 
Und wenn Ihr hoefflich zu mir seid
Schau ich auch mal bei euch vorbei
	die Toten Hosen - Streichholzmann
GNU/Linux 2.5.37 SMP/ReiserFS 2x1380 bogomips load av: 0.00 0.16 0.13
