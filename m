Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVGaXao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVGaXao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVGaXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:30:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262083AbVGaX3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:29:46 -0400
Date: Mon, 1 Aug 2005 01:29:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731232941.GG27580@elf.ucw.cz>
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122852234.13000.27.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm pretty sure at least one distro will go with HZ<300 real soon now
> > ;-).
> > 
> 
> Any idea what their official recommendation for people running apps that
> require the 1ms sleep resolution is?  Something along the lines of "Get
> bent"?

So you busy wait for 1msec, big deal. Some machines can't even keep
time properly with HZ=1000. Official recommendation is likely "help us
with CONFIG_NO_IDLE_HZ" or "get over it".
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
