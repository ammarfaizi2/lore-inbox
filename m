Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbTE1OXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbTE1OXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:23:04 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:15290 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S264748AbTE1OXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:23:02 -0400
Subject: Re: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
From: Stian Jordet <liste@jordet.nu>
To: Florin Iucha <florin@iucha.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030528133940.GT3359@iucha.net>
References: <170EBA504C3AD511A3FE00508BB89A92021C90DC@exnanycmbx4.ipc.com>
	 <1054128212.614.7.camel@chevrolet.hybel>  <20030528133940.GT3359@iucha.net>
Content-Type: text/plain
Message-Id: <1054132646.704.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 28 May 2003 16:37:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 28.05.2003 kl. 15.39 skrev Florin Iucha:
> On Wed, May 28, 2003 at 03:23:32PM +0200, Stian Jordet wrote:
> > > > This did not fix my problem. When I unload one ALSA-modules after the
> > > > other, the system hangs when I come to the "snd" module. No oops or
> > > > panic, it just freezes. Other than that, ALSA works fine for me, just
> > > > frustrating when I reboot.
> > > >
> > > > Best regards,
> > > > Stian
> > > 
> > > For what it's worth, maybe as a point to start to look for differences...
> > > 
> > > I am running 2.5.70-mm1, with snd-intel8x0 module.  Also SMP on Xeon P4
> > > (2up), Intel chipset.  I am not having any problems with unloading snd.
> > > 
> > > So maybe the difference is between -mm1 and (IIRC) -bk1.
> > 
> > Hmm. I will try -mm1 later today, but my problems started with
> > 2.5.68-bk18 (IIRC). This is also a SMP-system, Dual P3 (But VIA
> > chipset): But it's a pity you don't see the problem. I was hoping
> > everyone had it :) Well, I'll try to insert some printk's and stuff, and
> > see what happens. And try -mm1
> 
> Try -bk2: it contains Al Viro's second fix.

Thank you, this did indeed fix it. I'm usually good at catching changes
that is relevant for me, but this one slipped through. Thanks again :)

Best regards,
Stian

