Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273893AbRI3SOT>; Sun, 30 Sep 2001 14:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273883AbRI3SOK>; Sun, 30 Sep 2001 14:14:10 -0400
Received: from [194.213.32.137] ([194.213.32.137]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273723AbRI3SNw>;
	Sun, 30 Sep 2001 14:13:52 -0400
Date: Thu, 27 Sep 2001 14:27:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel pcmcia
Message-ID: <20010927142727.B39@toy.ucw.cz>
In-Reply-To: <3BAE24F4.4489CC4A@nyc.rr.com> <12891.1001275605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <12891.1001275605@redhat.com>; from dwmw2@infradead.org on Sun, Sep 23, 2001 at 09:06:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is cardmgr absolutely necessary?  I don't use modules, so I don't
> > really understand what cardmgr does that can't be done by the kernel
> > at boot. -
> 
> Aside from loading modules, it also performs the matching between devices 
> and drivers - rather than drivers registering a list of the devices they're 
> capable of driving, as with other bus types, cardmgr is required to 'bind' 
> devices to drivers.
> 
> The whole lot wants rewriting. I've been looking at it but don't have 
> anything that even compiles. 

Seconded. I need to see cardmgr dead for proper S3/S4 support without hacks.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

