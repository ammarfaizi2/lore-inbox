Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbSJXKXk>; Thu, 24 Oct 2002 06:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSJXKXk>; Thu, 24 Oct 2002 06:23:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:38531 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265377AbSJXKXj>;
	Thu, 24 Oct 2002 06:23:39 -0400
Date: Thu, 24 Oct 2002 12:29:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Osamu Tomita <tomita@cinet.co.jp>,
       Andrey Panin <pazke@orbita1.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
Message-ID: <20021024122930.E3243@ucw.cz>
References: <20021022065028.GA304@pazke.ipt> <3DB5706A.9D3915F0@cinet.co.jp> <1035374538.4033.40.camel@irongate.swansea.linux.org.uk> <3DB6A212.74D592D0@cinet.co.jp> <20021024110927.A2733@ucw.cz> <1035456308.8675.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1035456308.8675.36.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 24, 2002 at 11:45:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 11:45:08AM +0100, Alan Cox wrote:
> On Thu, 2002-10-24 at 10:09, Vojtech Pavlik wrote:
> > For system resources you simply could allocate 0x00-0x2f and be done
> > without the sparse flag, but if there are any other devices that have
> > overlapping resources, which need separate drivers (IDE, sound, network,
> > ...) then the sparse ioresource flag is indeed needed. Is it so?
> 
> Possibly although this is not an entirely unique problem. The other way
> would be (post 2.6) to add a mask. That will also let us properly handle
> the PCI/ISA partial decode for example.

Indeed.

-- 
Vojtech Pavlik
SuSE Labs
