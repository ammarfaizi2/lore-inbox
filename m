Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSHVJLs>; Thu, 22 Aug 2002 05:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSHVJLs>; Thu, 22 Aug 2002 05:11:48 -0400
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:11714 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S318572AbSHVJLr> convert rfc822-to-8bit; Thu, 22 Aug 2002 05:11:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Date: Thu, 22 Aug 2002 11:15:26 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208221115.26458.marc.dietrich@physik.uni-giessen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Hugh Dickens wrote:
> On Wed, 21 Aug 2002, James Bourne wrote:
> > On Wed, 21 Aug 2002, Reed, Timothy A wrote:
> > > 
> > > Can anyone lead me to a good source of information on what options > 
should be
> > > in the kernel for hyperthreading??  I am still fighting with a
> > > sub-contractor over kernel options.
> > 
> > As long as you have a P4 and use the P4 support you will get
> > hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 you have to also 
> > turn it on with a lilo option of acpismp=force on the kernel command line.
> 
> You do need CONFIG_SMP and a processor capable of HyperThreading,
> i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> just appropriate to that processor in other ways.

Hi,

I used KNOPPIX on a 2 way Dell WS 530 (Xeon 2.0 GHz). This distribution has 
CONFIG_M386 set (as most others also?) and HT was not enabled. I compiled the 
kernel myself (same config as KNOPPIX but with CONFIG_MPENTIUM4) and HT gets 
enabled. So is _does_ matter for which processor the kernel is optimized.

Greetings

Marc

-- 
Marc Dietrich

