Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbTBELCf>; Wed, 5 Feb 2003 06:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267913AbTBELCe>; Wed, 5 Feb 2003 06:02:34 -0500
Received: from poup.poupinou.org ([195.101.94.96]:63024 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267911AbTBELCe>; Wed, 5 Feb 2003 06:02:34 -0500
Date: Wed, 5 Feb 2003 12:08:55 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Banai Zoltan <bazooka@vekoll.vein.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU detection
Message-ID: <20030205110855.GD3240@poup.poupinou.org>
References: <20030204182603.GC3832@bazooka.saturnus.vein.hu> <1044399675.29825.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044399675.29825.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:01:16PM +0000, Alan Cox wrote:
> On Tue, 2003-02-04 at 18:26, Banai Zoltan wrote:
> > Hi!
> > 
> > I have a Toshiba Satelite S2210CDT.
> > There is a problem with detecting CPU frequency.
> > It runs on 258Mhz, but it is an 500Mhz Celeron kernels 2.4.19-pre7-ac4
> > and 2.4.20.
> > i attach the configs and the output of lscpi, /proc/cpu
> 
> I trust our measuring code. Most likely the laptop has speedstep so is 
> running at 250Mhz to save power. If you've got a currentish -ac kernel
> you can load the speedstep cpufreq support and flip the CPU between fast
> and slow mode as you want. In some cases APM will also do the work for
> you
> 

Celerons do not support speedstep, but BIOS can enable throttling (toshiba
like to make that in order to prevent heat issues), then APM idle calls
can perhaps help I guess.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
