Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129863AbQKHU6S>; Wed, 8 Nov 2000 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQKHU6K>; Wed, 8 Nov 2000 15:58:10 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:1552 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129863AbQKHU57>;
	Wed, 8 Nov 2000 15:57:59 -0500
Date: Wed, 8 Nov 2000 21:57:40 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: Richard Torkar <ds98rito@thn.htu.se>
cc: Jim Bonnet <jimbo@sco.com>, linux-kernel@vger.kernel.org
Subject: Re: sb.o support in 2.4-broken?
In-Reply-To: <Pine.LNX.4.21.0011082145490.2326-100000@toor.thn.htu.se>
Message-ID: <Pine.LNX.4.21.0011082157120.2326-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard Torkar wrote:

> Jim Bonnet wrote:
> 
> > I am using the 2.4.0-test10 kernel. I have a sound blaster 16 which
> > works fine under 2.2.17.
> >
> > I see that a while back someone posted on this problem previously but
> > there were no answers I can find..
> >
> > Is support for soundblaster16 ISA broken in the 2.4 kernel? Compiled in
> > or used as a module I can not get it to work. I have passed sb=220,5,1,5
> > during boot when compiled in and also sent those during insmod.
> >
> > When I boot to 2.2.17 these are the correct values and sound is happy :)
> >
> > I am subbed to this group so you may answer here so this is on record.
> >
> > Thanks much...
> 
> 
> What does 2.4.* say Jim?
> You have the right modutils installed?
> Any error msg?
> 
> I have an old SB16 ISA and it works without a problem on 2.4.0-test10.
> And it hasn't caused me any problems for a very long time :)
> 
> I have sound compiled as modules.
> My lilo.conf (sound part) looks like this.
     ^^^^^^^^^
Correction modules.conf I mean *duuuh*


> 
> path[sound]=/lib/modules/`uname -r`/kernel/drivers/sound
> alias sound-service-0-0 opl3
> alias sound-slot-0 sb
> options sound dmabuf=1
> alias midi opl3
> options opl3 io=0x388
> options sb io=0x220 irq=7 dma=1 dma16=5 mpu_io=0x330
> 
> I have no idea if the  sound-service-0-0 and sound-slot-0 part is right
> but it works and dosn't give any errors. I haven't had time to check what
> service and slot really affects...
> 
> Do you get any errors while inserting the modules?
> 
> 
> 
> /Richard
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> ------------ Output from gpg ------------
> gpg: Signature made Wed 08 Nov 2000 09:49:39 PM CET using DSA key ID 8A36DD1B
> gpg: Good signature from "Richard Torkar (Linux) <ds98rito@thn.htu.se>"
> 
> 

/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Cb5IUSLExYo23RsRAhWPAKC2seiMwCKfQaDhs0/eYrUhorciXQCg4bwh
VMBEDzjthtT6bjEn69mtAcM=
=83jY
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
