Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288702AbSADSCZ>; Fri, 4 Jan 2002 13:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288704AbSADSCJ>; Fri, 4 Jan 2002 13:02:09 -0500
Received: from mustard.heime.net ([194.234.65.222]:31923 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288702AbSADSBp>; Fri, 4 Jan 2002 13:01:45 -0500
Date: Fri, 4 Jan 2002 19:01:33 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Craig Knox <crg@monster.gotadsl.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <1010164038.2030.27.camel@crgs.lowerrd.prv>
Message-ID: <Pine.LNX.4.30.0201041900140.29991-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hm...

same problem with 2.4.18-pre1

[root@vs2 src]# modprobe e1000
/lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
/lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod
/lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o failed
/lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod e1000 failed

anyone that knows why?

On 4 Jan 2002, Craig Knox wrote:

> > When trying to insmod the driver, I get the following errors:
> >
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o failed
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod e1000 failed
> >
> > What's this? Is _mmx_memcpy only valid on Intel architecture? Does Athlon
> > have any equivalent system call?
>
> I had the same problem (unresolved symbol _mmx_memcpy) - I think it was
> with 2.4.17.
> Two solutions are -
> Compile your kernel as althon - compile module as something else (ie
> i386).
> or -
> Patch your 2.4.17 kernel to 2.4.18pre1 which doesn't have the problem
> and seems very stable to me.
>
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


