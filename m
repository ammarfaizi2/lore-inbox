Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUAQJQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUAQJQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:16:57 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:41355 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S266021AbUAQJQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:16:55 -0500
Date: Sat, 17 Jan 2004 10:13:37 +0100
From: Robert Schwebel <robert@schwebel.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Juergen Beisert <jbeisert@eurodsn.de>, cliff white <cliffw@osdl.org>,
       piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-ID: <20040117091337.GZ5139@pengutronix.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de> <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos> <20040117021532.GH12027@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040117021532.GH12027@fs.tum.de>
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Sat, Jan 17, 2004 at 03:15:32AM +0100, Adrian Bunk wrote:
> Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
> gave you any real difference (except your highest goal is to avoid a
> recompilation when switching from the Pentium 4 to the AMD Elan - but I
> doubt the really "prevents development").
> 
> But I'm not religious about this issue. Let Robert decide, the Elan 
> support is his child.
> 
> > > > - added optimizing CFLAGS for the AMD Elan
> > 
> > There are no such different "optimizations" for ELAN.
> 
> What's wrong wih the -march=i486 Robert suggested?

I've not followed the 2.6 development regarding the arch selection that
closely; let's collect arguments: 

- Is it still possible to run a -march=i486 built kernel on a pentium? 
  IMHO It would be good to optimize the code for i486, but I'm not that 
  familiar with how good gcc optimizes for 486 that I can comment this.

- I personally work with lots of cross architectures like ARM, so cross
  compiling for an embedded system is no problem for me. But if people
  want to test stuff on their pentiums I also have no problem with that.

Other arguments? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
