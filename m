Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQJ3LGe>; Mon, 30 Oct 2000 06:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129263AbQJ3LGY>; Mon, 30 Oct 2000 06:06:24 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5646 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129171AbQJ3LGR>; Mon, 30 Oct 2000 06:06:17 -0500
Date: Mon, 30 Oct 2000 05:05:43 -0600
To: Richard Henderson <rth@twiddle.net>, Keith Owens <kaos@ocs.com.au>,
        Pavel Machek <pavel@suse.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001030050543.A9175@wire.cadcamlab.org>
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> <4309.972694843@ocs3.ocs-net> <20001028131558.A17429@uni-mainz.de> <20001028172700.A13608@twiddle.net> <20001029160916.B12250@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029160916.B12250@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Sun, Oct 29, 2000 at 04:09:16PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [rth]
> > Which was a nice idea, but it doesn't actually work.  Changes
> > in spec file format between versions makes this fall over.

[Dominik Kubla]
> Wow. So much for reading the manual... well, that's considered
> cheating anyway, isn't it?

I know this was true at one time -- egcs couldn't read 2.7 spec files,
or something like that.  (I remember at the time thinking "so much for
the great and glorious '-V' theory".)

But I think it's since been fixed:

  $ gcc -v
  Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.2/specs
  gcc version 2.95.2 20000220 (Debian GNU/Linux)
  $ gcc -V2.7.2.3 -v
  Reading specs from /usr/lib/gcc-lib/i386-linux/2.7.2.3/specs
  gcc driver version 2.95.2 20000220 (Debian GNU/Linux) executing gcc version 2.7.2.3

Is there more subtle breakage?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
