Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSKZCAk>; Mon, 25 Nov 2002 21:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSKZCAk>; Mon, 25 Nov 2002 21:00:40 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:17561 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266006AbSKZCAj>;
	Mon, 25 Nov 2002 21:00:39 -0500
Date: Tue, 26 Nov 2002 02:11:00 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@freya.yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x
Message-ID: <20021126021100.GB29814@bjl1.asuk.net>
References: <Pine.GSO.4.33.0211251830050.6708-100000@sweetums.bluetronic.net> <20021126013330.93A962C365@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126013330.93A962C365@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> > Depmod no longer exists.
> 
> This is true.  It doesn't need to for 0.7, but it's being reintroduced
> in 0.8 for speed.

Doesn't it?  When I upgraded from 2.5.45 to 2.5.48, and installed
module-init-tools-0.7, a whole bunch of modules failed to load
automatically, and I ended up with no pcmcia, no network, no
af_packet, no loopback device...  I had to load them all manually.
Also no USB, hence no USB keyboard and mouse, but I haven't tried
loading those manually.

I thought it was depmod not working, but I must have been wrong.

So what happened - is there a known problem with module auto-loading
at the moment?

cheers,
-- Jamie
