Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSKZFWj>; Tue, 26 Nov 2002 00:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSKZFWj>; Tue, 26 Nov 2002 00:22:39 -0500
Received: from dp.samba.org ([66.70.73.150]:44175 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266128AbSKZFWh>;
	Tue, 26 Nov 2002 00:22:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x 
In-reply-to: Your message of "Tue, 26 Nov 2002 02:11:00 -0000."
             <20021126021100.GB29814@bjl1.asuk.net> 
Date: Tue, 26 Nov 2002 15:41:35 +1100
Message-Id: <20021126052954.9F7172C103@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021126021100.GB29814@bjl1.asuk.net> you write:
> Rusty Russell wrote:
> > > Depmod no longer exists.
> > 
> > This is true.  It doesn't need to for 0.7, but it's being reintroduced
> > in 0.8 for speed.
> 
> Doesn't it?  When I upgraded from 2.5.45 to 2.5.48, and installed
> module-init-tools-0.7, a whole bunch of modules failed to load
> automatically, and I ended up with no pcmcia, no network, no
> af_packet, no loopback device...  I had to load them all manually.
> Also no USB, hence no USB keyboard and mouse, but I haven't tried
> loading those manually.

Probably barfing on unimplemented modprobe options.  That's worked
around in the (coming) 0.8.

> I thought it was depmod not working, but I must have been wrong.
> 
> So what happened - is there a known problem with module auto-loading
> at the moment?

Should just work.  Details?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
