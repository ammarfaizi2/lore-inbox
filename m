Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319376AbSIFUps>; Fri, 6 Sep 2002 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319384AbSIFUps>; Fri, 6 Sep 2002 16:45:48 -0400
Received: from vulcan.americom.com ([208.187.207.195]:63989 "HELO
	solo.americom.com") by vger.kernel.org with SMTP id <S319376AbSIFUpr>;
	Fri, 6 Sep 2002 16:45:47 -0400
Date: 6 Sep 2002 20:50:26 -0000
Message-ID: <20020906205026.15331.qmail@solo.americom.com>
To: linux-kernel@vger.kernel.org
From: jeff@AmeriCom.com
Subject: Re: Linux SMP kernel bug with > 512M ram
Reply-To: jeff@AmeriCom.com
References: <1031332028.9945.74.camel@irongate.swansea.linux.org.uk> <20020906165516.17282.qmail@solo.americom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think its chipset or memory, the machines that crash have different brand 
motherboards with different chipsets, I ran docmem for 24 hours on each stick of ram 
and found no errors. The ram worked fine in my WindowsXP machine, and it works fine 
when I use the non-smp kernel, and/or when I take the ram down to 2 sticks (512 
meg). I'm posting here because I believe I have narrowed it down to a bug in the 
kernel.

> On Fri, 2002-09-06 at 17:55, jeff@AmeriCom.com wrote:
> > I've been having problems with a few of our servers and I can't seem to find 
this 
> > problem mentioned anywhere else. All of the dual processor machines will not 
operate 
> > with greater than 512 megs of ram with the newer SMP kernels (2.4.7-10enterprise 
#1 
> 
> 2.4.7 is hardly "new". Red Hat has issued errata kernels going up to
> 2.4.9.
> 
> > SMP). Two of the dual P3 1ghz machines crash after a few minutes, when the 
memory 
> > usage gets high enough, I presume. The errors they spit out vary, but its only 
when 
> > I go over 512megs of ram, and only on dual processor machines. I had a slightly 
> 
> Chipset or memory hardware problems seem the most likely cause if the
> errors seem random or weird
> 
> > different problem when I tried to set it up on a dual p2 266 machine, when I go 
over 
> > 512 megs there, the system takes an hour to boot up, and everything crawls from 
> 
> Thats BIOS. Thats a well known BIOS problem where the BIOS doesnt
> configure the mtrr registers properly. You can work around that one by
> tweaking the settings by hand or probably by getting a newer BIOS 
> 
> 
> 

