Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281258AbRKLF21>; Mon, 12 Nov 2001 00:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281259AbRKLF2S>; Mon, 12 Nov 2001 00:28:18 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:36878 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281258AbRKLF2H>;
	Mon, 12 Nov 2001 00:28:07 -0500
Date: Sun, 11 Nov 2001 21:28:05 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011111212805.A31458@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>, <3BEF27D1.7793AE8E@zip.com.au>; <20011111205411.B30782@lucon.org> <3BEF5ABB.78254C5F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEF5ABB.78254C5F@zip.com.au>; from akpm@zip.com.au on Sun, Nov 11, 2001 at 09:14:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 09:14:35PM -0800, Andrew Morton wrote:
> "H . J . Lu" wrote:
> > 
> > > Incidentally, it would be nice to be able to get this driver working
> > > properly when linked into the kernel - it makes debugging much easier :)
> > >
> > 
> > I guess I can try that. The only main issue will be the order of
> > initialization.
> > 
> 
> Actually, it almost works.  If you link the drivers into the kernel
> and, after bootup, attach a firewire drive and run rescan-scsi-bus.sh
> it will pick up the new devices.  It's just the bus scan at initcall
> time which fails.

I will look into that.

H.J.
