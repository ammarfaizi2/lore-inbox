Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313045AbSDEROj>; Fri, 5 Apr 2002 12:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSDEROV>; Fri, 5 Apr 2002 12:14:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:44553 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S313045AbSDEROE>;
	Fri, 5 Apr 2002 12:14:04 -0500
Date: Fri, 5 Apr 2002 19:14:41 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Arnvid Karstad <arnvid@karstad.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems rebooting from linux to windows...
In-Reply-To: <Pine.LNX.3.95.1020405083239.21764A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.10.10204051904210.654-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Richard B. Johnson wrote:

> On Fri, 5 Apr 2002, Arnvid Karstad wrote:
> 
> > Hi, 
> > 
> > recently I've seen a few problems with several laptops and if one are so 
> > unfortunate that one needs to reboot into Windows after a session in linux.
> > Normal restart of windows never have a problem on the same machines, but if 
> > you go from Linux to for instance Windows by shutdown -r or reboot it will 
> > freeze half way into the booting process. 
> > 
> > A power cycle will hower fix this. 
> > 
> > Anyone got an idea about where to start looking? 
> > 
> > Best regards 
> > 
> > Arnvid Karstad
> 
> I have this same problem on my Compaq Presario. I think that this
> is because the BIOS was shadowed and used some writable-RAM somewhere.
> Linux seems to do a 'warm-boot'. The result being that some of the
> stuff that the BIOS counts on was wiped out by Linux, i.e.,
> stuff from E000:0000 -> E000:FFFF (the BIOS is normally at F000:0000).
> 
> My 'fix' is to cold-boot, i.e., processor reset during the shutdown.

FWIW, I also have a Presario, and reboot frequently between Windbloz
and Linux with zero problems. I've seen many many many problems wrt
Compaq (mostly crap bios) and Linux over the years, but ATM, I don't
have any.  (I put total >$20k into a 386-20 believe it or not.. was
shit hot box at the time:)

	-Mike

