Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbRBRAC0>; Sat, 17 Feb 2001 19:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132214AbRBRACJ>; Sat, 17 Feb 2001 19:02:09 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:63511 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129942AbRBRABv>; Sat, 17 Feb 2001 19:01:51 -0500
Date: Sun, 18 Feb 2001 02:01:40 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Nate Eldredge <neldredge@hmc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
Message-ID: <20010218020140.F5199@niksula.cs.hut.fi>
In-Reply-To: <14990.18933.849551.526672@mercury.st.hmc.edu> <E14UE0r-00071Q-00@the-village.bc.nu> <14990.57922.176851.105401@mercury.st.hmc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14990.57922.176851.105401@mercury.st.hmc.edu>; from neldredge@hmc.edu on Sat, Feb 17, 2001 at 12:42:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 12:42:42PM -0800, you [Nate Eldredge] claimed:
> Alan Cox writes:
>  > > # mount -t ext2 -o loop /spare/i486-linuxaout.img /spare/mnt
>  > > loop: enabling 8 loop devices
>  > 
>  > Loop does not currently work in 2.4. It might partly work by luck
>  > but thats it.  This will change as and when the new loop patches go
>  > in. Until then if you need loop use 2.2
> 
> I see.  Thank you.  I can live without it until then.
> 
> Btw, I applied Jens Axboe's loop-3 patch as suggested by Ville Herva.
> It applied with some fuzz and offset.  However, when I booted it, the
> kernel oopsed when I tried to mount the first ordinary ext2 partition
> (no loopback involved).  I can post the oops if anyone cares, but I
> presume that loop-3 and 2.4.1ac17 are just incompatible.

I'm not sure if it'll apply any more cleanly (and work), but the newest is
loop-4 at

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre1

(It should work with 2.4.1pre1, at least).


-- v --

v@iki.fi
