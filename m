Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSE1UBS>; Tue, 28 May 2002 16:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSE1UBS>; Tue, 28 May 2002 16:01:18 -0400
Received: from fep01.tuttopmi.it ([212.131.248.100]:31230 "EHLO
	fep01-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S316895AbSE1UBR>; Tue, 28 May 2002 16:01:17 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Frederik Nosi <fredi@e-salute.it>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1022610217.4123.133.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 May 2002 22:03:53 +0200
Message-Id: <1022616234.2427.34.camel@linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il mar, 2002-05-28 alle 20:23, Alan Cox ha scritto:
> On Tue, 2002-05-28 at 18:10, Andre Hedrick wrote: 
> > 99% bet it is a timing problem in the VIA mainboard.
> > VIA has always had problems first from attempts to allow it to do PIO5
> > which does not exist.  Basic hotrodding of the timings has always been a
> > problem.  Other issues include basic design flaws in the the VIA reference
> > docs for board makers.
> > 
> > If you are using quality junk^VIA mainboards, you will not have issues.

Sadly now I was booting again that box; this is what the bios test is
saying:

<bios>
Failure Predicted on Primary Master: QUANTUM FIREBALLlct10 15
Immediatly back-up your data and replace your hard disk drive.
A failure may be imminent
</bios>

Ok, my mainboard is an ASUS K7V-RM with the VIA's kx133 chipset (the
first chipset for athlon with agp 4x && 133 pci if it matters).
So:
Bios: Havard Medallion v6.0
chipset:
Via VT 8371 516 BGA north bridge
Via 82C686A south bridge

Integrated in the mainboard there is an yamaha audio chip witch I'm not
using
Other pieces of hardware are a Matrox g400 max video card that works
happily and a cheap eth, pcnet or something
My HD is a quantum fireball lct10 15 (15 Gb capacity)


> So why wasn't it showing up before. Obviously something we changed is
> triggering a situation that board or otherwise wasn't there before. 
> 

I will be happy if it was the case, but I think that it is really a
hardware problem :(
However, this box has worked with kernels from 2.0.X till the last
vanilla 2.4.19-pre8 . I've used the box with 2.4.19-pre8 from the day
the prepatch have seen the web till ~4 days ago with the same workload,
so if it was that the kernel is buggy, I will have noticed it from the
first days that I've installed it. And I've used this HD for 2 years to
now. A glorious death :)

However if you need info, tests to do or whatever I'm happy to do it.
Maybe this hd will help for something.


Thank you for your replies, you rock guys :)
Fredi

