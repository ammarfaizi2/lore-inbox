Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJ1O6C>; Mon, 28 Oct 2002 09:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJ1O6B>; Mon, 28 Oct 2002 09:58:01 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:64843 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261293AbSJ1O55>;
	Mon, 28 Oct 2002 09:57:57 -0500
Date: Mon, 28 Oct 2002 16:04:10 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, ducrot@poupinou.org
Subject: Re: cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available
Message-Id: <20021028160410.1d0f9a78.gigerstyle@gmx.ch>
In-Reply-To: <20021028162932.B888@brodo.de>
References: <20021026105611.3d6a540c.gigerstyle@gmx.ch>
	<12722.1035652076@www50.gmx.net>
	<20021028162932.B888@brodo.de>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik, Hi Bruno!

Thank you for the information!

> Intel continues to withhold information on how to use SpeedStep on
> 440BX/MX chipsets (and even removes documentation which had been > publicly available ontheir servers)

I thought Intel is interessted in Linux and want to support it????

I'm willing to help you with tests if you want, so that the 440BX chipset will be supported.

Thank's

Marc

On Mon, 28 Oct 2002 16:29:33 +0100
Dominik Brodowski <linux@brodo.de> wrote:

> Hi Marc,
> 
> > Why is cpufreq on my laptop not available? I know it works with window$.
> > My laptop has an Intel P3 speedstep cpu which supports 600Mhz and 500Mhz
> > clock frequency. Will it be supported in the future?
> >
> > CPU model name      : Pentium III (Coppermine)
> >
> > 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
> 
> There's a small bug in speedstep.c which causes the initialization process
> to fail on all Coppermines. A fix for this had been sent to Linus already;
> it's also attached.
> 
> Unfortunately, this won't change much on your notebook. Now the line in
> dmesg will say "Intel SpeedStep for this chipset not (yet) available." as
> Intel continues to withhold information on how to use SpeedStep on 440BX/MX
> chipsets (and even removes documentation which had been publicly available on
> their servers). However, in an effort mainly lead by Bruno Ducrot,
> reverse-engineering is making progress. SpeedStep already works on some
> 440BX/MX based notebooks, on others -like the one I'm using- it's still a
> mystery. 
> 
> During the next days, I'll make a patch and further information available.
> 
> 	Dominik
> 
