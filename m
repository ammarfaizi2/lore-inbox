Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313432AbSC2Kkq>; Fri, 29 Mar 2002 05:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313433AbSC2Kkg>; Fri, 29 Mar 2002 05:40:36 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38858 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313432AbSC2Kk0>; Fri, 29 Mar 2002 05:40:26 -0500
Date: Fri, 29 Mar 2002 11:40:25 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Screen goes blank, but I don't want
Message-ID: <20020329104025.GA14805@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203290916500.6563-100000@helka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all!
> 
> There is a machine which display I want to keep showin' on all the time.
> It is the same when on X or console, the screen goes blank in around 20
> minutes.
> 
> kernel 2.4.10-2.4.18, debian woody, with all powermanagement turned off
> and not compiled in the kernel nor module, no apmd, acpid running, apm is
> turned off in the bios, happens with both vesafb and plain vga text
> console, too.
> 
> X is configured no to use DPMS, all blank params eq 0
> 
> It happens on several machines, any idea?

I think that console blanking is never completely turned off in kernel
config. It must be turned of using setterm (setterm -blank 0). Similar
for X. They blank the screen by default even without DPMS - use xset to
turn that off.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
