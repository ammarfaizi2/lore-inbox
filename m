Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267940AbTBVWOF>; Sat, 22 Feb 2003 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTBVWOF>; Sat, 22 Feb 2003 17:14:05 -0500
Received: from unet.univie.ac.at ([131.130.221.38]:34435 "EHLO
	unet.univie.ac.at") by vger.kernel.org with ESMTP
	id <S267940AbTBVWOE> convert rfc822-to-8bit; Sat, 22 Feb 2003 17:14:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Hofer <th@monochrom.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Box freezes if I enable "AMD 76x native power management"
Date: Sat, 22 Feb 2003 23:21:27 +0100
User-Agent: KMail/1.4.3
References: <20030222163057.A884@namesys.com> <20030222185329.GA22170@morningstar.nowhere.lie>
In-Reply-To: <20030222185329.GA22170@morningstar.nowhere.lie>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302222321.27820.th@monochrom.at>
X-DCC-ZID-Univie-Metrics: mx1 4261; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 February 2003 19:53, John W. M. Stevens wrote:
> On Sat, Feb 22, 2003 at 04:30:57PM +0300, Oleg Drokin wrote:
> >    Starting from 2.4.20 until now (including 2.4.21-pre4 and
> > 2.4.21-pre4-ac5", whenever I enable "AMD 76x native power
> > management" in my kernel config, I get kernel that hangs at boot
> > after reporting elevator stuff about my IDE drives. Is anybody
> > interested?
> [..]
> 1) Exact Mother board (Tyan what?  Tiger MPX 2466N . . . ?)
> 2) Do you have DMA turned on for your IDE drives?
> 3) Are you enabling the AMD chip support for IDE?
>
> . . . and anything else you can find out about the box?
>
> Most importantly . . . does the problem go away if you turn off DMA
> support for IDE?

I have some problems with this hardware, too. Maybe I can provide some 
useful bugreports - I'd gladly do some tests with the 2.4.x kernels if 
someone is interested (I only tried 2.4.19 and 2.4.20 with this 
hardware so far).

I have a Tyan S2466N-4M (Tiger MPX, Chipset AMD 760MPX, 762, 768), 
2x Athlon MP 2000+, 
512MB Reg. ECC SDRAM
2-3 IDE drives and a DVD-ROM on the onboard channels
DMA support enabled (I don't like to disable this, because when I copy 
over 100MB from the DVD to a harddrive with DMA disabled the cpu-usage 
wents well above 50% and then the machine _freezes_.)

With 2.4.19, the power-switch didn't work after shutdown (It works now 
with 2.4.20). Automatic power-off (halt -p) doesn't work with neighter 
2.4.19 nor 2.4.20. 

With "AMD 76x native power management" I experienced freezes under X11 
when the system was idle for about 30 min that usually went away when I 
typed on the keyboard. Using the (USB) mouse had no effect. But I had 
no problems at boot-time.

Thomas.


