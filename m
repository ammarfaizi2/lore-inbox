Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280695AbRKJT7q>; Sat, 10 Nov 2001 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280694AbRKJT7g>; Sat, 10 Nov 2001 14:59:36 -0500
Received: from md.hub.gts.cz ([194.213.32.136]:54145 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S280692AbRKJT7Y>;
	Sat, 10 Nov 2001 14:59:24 -0500
Date: Sat, 1 Jan 2000 00:31:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Samium Gromoff <_deepfire@mail.ru>, Dominik Kubla <kubla@sciobyte.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Laptop harddisk spindown?
Message-ID: <20000101003147.C35@(none)>
In-Reply-To: <200111080502.fA852im17980@vegae.deep.net> <1005221273.13841.19.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1005221273.13841.19.camel@nomade>; from xavier.bestel@free.fr on Thu, Nov 08, 2001 at 01:07:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 	i have a disk access _every_ 5 sec, unregarding the system load, 
> > > >     24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
> > > >     bound boxes...
> 
> That's a kernel daemon called kupdated. Under Linux buffers are flushed
> every 5 seconds (I don't like this myself, it should be triggered by
> something dependant on free mem, dirty buffers, disk access, etc. but
> not time, this doesn't scale.
> 
> Under 2.2 you can try the noflushd package - perhaps it works on 2.4, I
> haven't tried. It works more or less.

noflushd does work on 2.4
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

