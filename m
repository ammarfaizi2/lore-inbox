Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRJTWUl>; Sat, 20 Oct 2001 18:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJTWUb>; Sat, 20 Oct 2001 18:20:31 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:34702 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S274749AbRJTWUP>; Sat, 20 Oct 2001 18:20:15 -0400
Message-Id: <5.1.0.14.2.20011020231347.00b81ef8@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 20 Oct 2001 23:20:44 +0100
To: Ben Greear <greearb@candelatech.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Input on the Non-GPL Modules
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Niehusmann <jan@gondor.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BD1F5CC.20BF3F20@candelatech.com>
In-Reply-To: <E15v4Dz-0002VM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:08 20/10/2001, Ben Greear wrote:
>Alan Cox wrote:
> >
> > > What prevents the author of a non-GPL module who needs access to a
> > > GPL-only symbol from writing a small GPLed module which imports the
> > > GPL-only symbol (this is allowed, because the small module is GPL),
> > > and exports a basically identical symbol without the GPL-only
> > > restriction?
> >
> > The fact that it ends up GPL'd to be linked (legal derivative work sense)
> > to the GPL'd code so you can link it to either but not both at the same 
> time
>
>If you own the copyright to the small shim GPL piece, can anyone else
>take legal action on your part?  If not, then all you have to do is not
>sue yourself for the double linkage and no one else can sue you either....

And even if yes, one could just implement the "shim GPL piece" as a server 
with an exported binary access interface (use of a CORBA implementation 
springs to mind for example) and the non-GPL code then functions as a 
client to the server. Nobody can say that that is not legal. Otherwise you 
would have to demand that all network clients accessing Linux servers 
become open source which could never be upheld...

Lets face it. (Wo)Man is intelligent enough to be able design at least one 
circumvention technique for every prevention technique one can think of, 
all one can do is make it awkward to circumvent but trying to prevent 
circumvention at all costs is an exercise in futility IMHO.

Just my 2p. sorry for jumping into the middle of a discussion...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

