Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSFXJH3>; Mon, 24 Jun 2002 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSFXJH2>; Mon, 24 Jun 2002 05:07:28 -0400
Received: from static62-99-146-174.adsl.inode.at ([62.99.146.174]:28326 "EHLO
	silo.pitzeier.priv.at") by vger.kernel.org with ESMTP
	id <S311025AbSFXJH0>; Mon, 24 Jun 2002 05:07:26 -0400
Reply-To: <oliver@linux-kernel.at>
From: "Oliver Pitzeier @ Home" <oliver@linux-kernel.at>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
       "'Jurriaan on Alpha'" <thunder7@xs4all.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Boot problems (WAS: RE: 2.5.24 doesn't compile on Alpha)
Date: Mon, 24 Jun 2002 11:05:28 +0200
Organization: linux kernel austria
Message-ID: <000601c21b5e$4d203f70$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <000901c21abf$e1a11060$1201a8c0@pitzeier.priv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan!

Oliver Pitzeier wrote:
> Ivan Kokshaysky wrote:
> > On Fri, Jun 21, 2002 at 04:19:57PM +0200, Jurriaan on Alpha wrote:
> > > I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h
> > (the non-smp
> > > section) but the same line in include/asm/mmu_context.h
> > works - for a
> > > while.
> > 
> > I'm running 2.5.24 on sx164 with following (unfinished - SMP
> > is broken) patch.
> 
> The patch worked well and did what my patch did not yet. :o)
> I compiles without problems. I'll try to boot the machine 
> tommorow (at work).
> 
> I'll send you the results. :o)

I cannot boot the kernel... Here's the problem... But what does this
mean? "swapper"? Has this something to do with swap?

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed
Kernel bug at ll_rw_blk.c:1639
swapper(1): Kernel Bug 1
pc = [<fffffc00003f7bb8>]  ra = [<fffffc00003f7cdc>]  ps = 0000    Not
tainted
v0 = 0000000000000000  t0 = 0000000000000001  t1 = 0000000000000040
t2 = fffffc000fdcbae0  t3 = fffffc00005514e8  t4 = 0000000000000001
t5 = fffffc000e6e0120  t6 = fffffc000e6e00c0  t7 = fffffc00007e8000
a0 = fffffc000fec3da0  a1 = fffffc000fec3da0  a2 = fffffc00007eb498
a3 = fffffc00007eb4a8  a4 = fffffc00007eb490  a5 = fffffc00005260b0
t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000000007370
t11= 8e38e38e38e38e39  pv = fffffc00003f7c80  at = fffffc00007a1798
gp = fffffc000054b6c8  sp = fffffc00007eb530
Trace:fffffc00003f7cdc fffffc00003794a4 fffffc00003797f4
fffffc0000379af8 fffffc000031fbb0 fffffc00003c4040 fffffc00003c4074
fffffc000033c694 fffffc000033c878 fffffc000038d490 fffffc000038e8ec
fffffc000038d490 fffffc000035073c fffffc0000350824 fffffc000033d3cc
fffffc000033dad8 fffffc000033d970 fffffc000035f3c4 fffffc0000360178
fffffc000031085c fffffc0000310214 fffffc00003107d8 fffffc0000310cc8
fffffc000032466c fffffc000031008c fffffc00003100b0 fffffc00003107c0 
Code: 00000081  00000616  0050e86a  fffffc00  c3ffffe7  00000081
<00000667> 0050e86a 
Kernel panic: Attempted to kill init!

Greetz,
   Oliver


