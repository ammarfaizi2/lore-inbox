Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVGaXx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVGaXx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVGaXx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:53:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:54933 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262156AbVGaXx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:53:57 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050731232941.GG27580@elf.ucw.cz>
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>  <20050731232941.GG27580@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 19:53:55 -0400
Message-Id: <1122854036.13000.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 01:29 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I'm pretty sure at least one distro will go with HZ<300 real soon now
> > > ;-).
> > > 
> > 
> > Any idea what their official recommendation for people running apps that
> > require the 1ms sleep resolution is?  Something along the lines of "Get
> > bent"?
> 
> So you busy wait for 1msec, big deal.

Which requires changing all those apps.  I thought we tried not to break
userspace with minor kernel version upgrades.

> Some machines can't even keep time properly with HZ=1000.

If your workaround for broken hardware involves screwing over people
with good hardware, it might be the wrong workaround.

>  Official recommendation is likely "help us
> with CONFIG_NO_IDLE_HZ" or "get over it".

IOW, "if you don't like it, get another distro, or compile your own
kernel".

Lee

