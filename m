Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157641AbQGaO4D>; Mon, 31 Jul 2000 10:56:03 -0400
Received: by vger.rutgers.edu id <S157510AbQGaOzK>; Mon, 31 Jul 2000 10:55:10 -0400
Received: from pec-58-36.tnt4.b2.uunet.de ([149.225.58.36]:2791 "EHLO router.abc") by vger.rutgers.edu with ESMTP id <S157586AbQGaOyB>; Mon, 31 Jul 2000 10:54:01 -0400
Message-ID: <39859644.340AE15E@baldauf.org>
Date: Mon, 31 Jul 2000 17:07:49 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en,de-DE
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu



Matthias Andree wrote:

> On Mon, 31 Jul 2000, Xuan Baldauf wrote:
> > Matthias Andree wrote:
> > You tell me the kernel starts missing drive ACKs even if there are no read
> > or write requests pending? Even then, the drive was never in sleep mode
> > (requires reset), it always was in standby mode (does not require reset). My
> > primary intent is to reduce the noise of the drive, not the power
> > consumption.
>
> Of course, if the kernel is not writing, it's not missing "operation
> complete" transactions.
>
> My point is: putting a drive to sleep rather than to standby will not
> help much, it will only delay the spin-up and possibly leave you with a
> slower drive.

But I never wanted it to be in sleep (rather than standby) mode, my original
intent was to bring the system to a state where spin ups are only done when
necessary. Someone said something about noflushd, but I could not find any links
or rpm packages, does anybody have...?

Maybe the off-topic discussion is going to be off-topic of the off-topic... ;o)

Xuân.:o)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
