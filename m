Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSJALUo>; Tue, 1 Oct 2002 07:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJALUn>; Tue, 1 Oct 2002 07:20:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10120 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261579AbSJALUi>;
	Tue, 1 Oct 2002 07:20:38 -0400
Date: Tue, 1 Oct 2002 13:25:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20021001112523.GP3867@suse.de>
References: <20020929091229.GA1014@suse.de> <Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com> <20021001062630.GM3867@suse.de> <15769.21706.618421.684462@kim.it.uu.se> <1033471870.20103.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033471870.20103.4.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Alan Cox wrote:
> > - Same ..._intr errors on my 486 with a qd6580 VLB controller.
> >   It also has, in post-2.5.36 kernels, an instant-reboot problem which
> >   occurs whenever I pass the ide0=qd65xx kernel option required to
> 
> Seems to be specific to the 2.5.x version of the new ide so I guess its
> a port error (or just bad luck it now breaks and was iffy before)

ok, I'll try it in 2.5 then

> > - My Intel AL440LX box (440LX chipset, 20G Quantum Fireball) worked
> >   brilliantly up to 2.5.36, but hangs *hard* with 2.5.39 as soon
> >   as I tar zxf the kernel source tarball.
> >   (May or may not be IDE. I'll try a minimal 2.5.39 tonight.)
> 
> Thats PIIX, which should be the most boringly stable configuration of
> the lot 8(

There's no evidence that this is an ide error yet. I'd like to see some
serial console or similar on that beast. I have no LX board here, but
piix is rock solid.

-- 
Jens Axboe

