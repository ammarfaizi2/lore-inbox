Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272220AbRIOKZ4>; Sat, 15 Sep 2001 06:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRIOKZf>; Sat, 15 Sep 2001 06:25:35 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:30738 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272218AbRIOKZ1>; Sat, 15 Sep 2001 06:25:27 -0400
Message-ID: <3BA32C51.B4D9B14@t-online.de>
Date: Sat, 15 Sep 2001 12:24:17 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeffrey Ingber <jhingber@ix.netcom.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Random Sig'11 in XF864 with kernel > 2.2.x
In-Reply-To: <1000530589.2267.11.camel@DESK-2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Ingber schrieb:
> 
> Hello kernel developers:
> 
> I'm experiencing random Signal 11's on kernels in the 2.4 series with
> XFree86 4 and SMP configurations.  Here a some threads to the XFree86
> mailing lists which suggest that the Signal 11's are kernel related.
> Downgrading to a 2.2 series kernel solves these problems:
> 
> http://www.xfree86.org/pipermail/xpert/2001-September/011053.html
> http://www.xfree86.org/pipermail/xpert/2001-September/011229.html
> 
> Here's a snippet from my posting to the list:
> 
> ----
> > Dell PowerEdge 6300 (Quad Xeon 500) with ATI Rage 128
> > IBM Netfinity 5600 (Dual PIII 667) with Matrox MMS Quad Monitor
> > Tyan Tunderbolt S1873UANG-R (Dual PIII 600) with Matrox Marvel G400
> 
>    I'll bet it goes away if you don't use a 2.4 SMP kernel.
> That is, use a 2.4 UP kernel or a 2.2 UP/SMP kernel.
> ---
> 
> And this turned out to be the case.  Is there anything that I could do
> help fix this?  Is there anyone else on this list that has had similar
> problems and has overcome this?
> 

Hello..

I can only admit that i also know this problem.

I run a RH7.1 on a dual-PIII/850 with a Matrox G400/16MB, and i also had
several crashes of X, mostly when Netscape runs, but some without it.

What i did:
I changed the default colourdepth from 24 to 16 and i got the "original"
mga.o-modules from www.matrox.com.

But this did not help, i suffered a crash some days ago again, but this
time i had a logentry, it said:

---------
Sep 12 13:14:27 falcon kernel: [drm] Process 850 dead (ctx 1, d_s =
0x00)
---------

I run XFree 4.0.3 and have enabled the Matrox-Options in the Kernel
under "Character devices - Support for Matrox g200/g400", but this did
not help either.

Another problem i got by using the modules from "matrox.com", i cannot
switch between consoles and X anymore, if i switch back to X several
times (one time usually is ok), the whole machine crashes, i have to
reboot via SysRq and even that does not work everytime. But this is
related to the "mga.o"-module from matrox, i hadnt this effect with the
mga.o from XFree86.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
