Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129790AbQK1NXC>; Tue, 28 Nov 2000 08:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130038AbQK1NWx>; Tue, 28 Nov 2000 08:22:53 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:41281 "EHLO
        twilight.cs.hut.fi") by vger.kernel.org with ESMTP
        id <S129790AbQK1NWh>; Tue, 28 Nov 2000 08:22:37 -0500
Date: Tue, 28 Nov 2000 14:52:29 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
Message-ID: <20001128145229.O53529@niksula.cs.hut.fi>
In-Reply-To: <20001128134418.C54301@niksula.cs.hut.fi> <E140k8t-0004Sv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E140k8t-0004Sv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 28, 2000 at 12:45:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 12:45:49PM +0000, you [Alan Cox] claimed:
> > BTW: What are those seemingly harmless "VFS: busy inodes on changed
> > media." messages I'm getting tons of?
> 
> They are not harmless. Someone forcibly unmounted a disk of some sort
> from a device that was in use, and while that shouldnt have killed the box
> it seems it did

I've got hundreds of those during several weeks, and in different boots.
It seems the kernel starts spitting them right after using cdrom.

I wasn't the one who used cdrom, so it is possible, that the person in
question had been able to eject the cd without unmounting it first. I'll
check if the door locking on that device works.

But you are certain that the oops was eventually caused by these and not
by any bug in vm?


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
