Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQKSUgJ>; Sun, 19 Nov 2000 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQKSUf7>; Sun, 19 Nov 2000 15:35:59 -0500
Received: from [194.213.32.137] ([194.213.32.137]:11013 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129413AbQKSUfZ>;
	Sun, 19 Nov 2000 15:35:25 -0500
Date: Sat, 18 Nov 2000 18:54:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
Message-ID: <20001118185441.B177@toy>
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva> <20001118223455.G23033@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001118223455.G23033@almesberger.net>; from Werner.Almesberger@epfl.ch on Sat, Nov 18, 2000 at 10:34:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi1

> > Did you try to load an initrd on a low-memory machine?
> > It shouldn't work and it probably won't ;)
> 
> You must be really low on memory ;-)
> 
> # zcat initrd.gz | wc -c
>  409600
> 
> (ash, pwd, chroot, pivot_root, smount, and still about 82 kB free.)

Your solution requires 400K initrd _plus_ memory for ash and swapon. That
might be easily 600K total. Yes I could imagine machine with freemem less
than that. However such machines do not usually have swap available.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
