Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSGJTgg>; Wed, 10 Jul 2002 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSGJTgf>; Wed, 10 Jul 2002 15:36:35 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:41201 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317586AbSGJTge>; Wed, 10 Jul 2002 15:36:34 -0400
Date: Wed, 10 Jul 2002 02:43:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Oliver Neukum <oliver@neukum.name>, Keith Owens <kaos@ocs.com.au>,
       Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates
Message-ID: <20020710004320.GC596@elf.ucw.cz>
References: <200207091030.17096.oliver@neukum.name> <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -It is slow.
> 
> I wouldn't call it any fast when I think about the idea that 31 of my CPUs 
> on Hawkeye shall be stopped because I unload a module. Sometimes at high 
> noon my server (Hawkeye) can hardly keep up all the traffic. Just imagine 
> a module would be unloaded then! That's the problem I'm having with it.
> 
> What should make a lock for parts of the kernel slower than a lock for 
> the _whole_ kernel?

Lock for the whole kernel has less impact over overall code, I
believe.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
