Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTE1NJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbTE1NJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:09:13 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:57785 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S264722AbTE1NJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:09:10 -0400
Subject: RE: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
From: Stian Jordet <liste@jordet.nu>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A92021C90DC@exnanycmbx4.ipc.com>
References: <170EBA504C3AD511A3FE00508BB89A92021C90DC@exnanycmbx4.ipc.com>
Content-Type: text/plain
Message-Id: <1054128212.614.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 28 May 2003 15:23:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 28.05.2003 kl. 14.55 skrev Downing, Thomas:
> -----Original Message-----
> From: Stian Jordet [mailto:liste@jordet.nu]
> >
> > tir, 27.05.2003 kl. 20.51 skrev viro@parcelfarce.linux.theplanet.co.uk:
> >> 	Argh.  Missing initialization in char_dev.c - it's definitely
> >> responsible for crap on unload.  Load side appears to be something >else,
> >> though...
> >
> > This did not fix my problem. When I unload one ALSA-modules after the
> > other, the system hangs when I come to the "snd" module. No oops or
> > panic, it just freezes. Other than that, ALSA works fine for me, just
> > frustrating when I reboot.
> >
> > Best regards,
> > Stian
> 
> For what it's worth, maybe as a point to start to look for differences...
> 
> I am running 2.5.70-mm1, with snd-intel8x0 module.  Also SMP on Xeon P4
> (2up), Intel chipset.  I am not having any problems with unloading snd.
> 
> So maybe the difference is between -mm1 and (IIRC) -bk1.

Hmm. I will try -mm1 later today, but my problems started with
2.5.68-bk18 (IIRC). This is also a SMP-system, Dual P3 (But VIA
chipset): But it's a pity you don't see the problem. I was hoping
everyone had it :) Well, I'll try to insert some printk's and stuff, and
see what happens. And try -mm1

Best regards,
Stian

