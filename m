Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282405AbRKXJD1>; Sat, 24 Nov 2001 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282406AbRKXJDS>; Sat, 24 Nov 2001 04:03:18 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:9857 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282405AbRKXJDM>; Sat, 24 Nov 2001 04:03:12 -0500
Message-ID: <00de01c174c6$d4d092b0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
        "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10111232239100.32407-100000@master.linux-ide.org>
Subject: Re: IDE is still crap.. or something
Date: Sat, 24 Nov 2001 10:03:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>; "lkml"
<linux-kernel@vger.kernel.org>
Sent: Saturday, November 24, 2001 8:06 AM
Subject: Re: IDE is still crap.. or something


> On Fri, 23 Nov 2001, Martin Eriksson wrote:
>
> > > > any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14
IDE
> > > > patch (after fixing the rejects) but no go.
>
> Mr. Martin Eriksson,
>
> As for your subject -- "IDE" died a long time ago, but since it died
> before you entered university, I am not at all surprized.  Now as for
> jumping on the case of the talented Mr. Marcelo Tosatti.  He has not found
> it neccessary to enter university at this time, as he could likely teach
> the content scheduled in the next year to you.
>
> Why are you doing thoughtless things like overriding the ruleset for
> optimizing the HOST/Device pair?  I seriously doubt that you know the
> history of those option?  Of the lot, one of them is retired as of ATA-2;
> however it still is optional for a while.  The other is foolish in most
> cases unless dealing with ATA-2 hardware, or have audio driver problems.
> The next is settable by the kernel if you allow it to do the work for you.
> The last is also set by the kernel, should you allow it to operate.  There
> is no valid reason for you to do anything w/ hdparm.

Well, actually I'm not the "must-use-hdparm -c1 -u1 -d1 -m16 -W1 -X66" kind
of guy... I just tested some options because my system was slow. I do not
run hdparm now, and everything works fine (with your ATA patch, and the
preempt patch). I'm moving the hard disks to the "on-board" controller
(PIIX) today, to see if that works better (without preempt+ata).

Also, I *would* be upgrading my linux system *if I had money*, but until
then, I happily run with my crappy BP6, crappy HD's and crappy HPT366
controller.

> Now this is a global reply to your list of rants.  Now if you can not
> merge patches and understand what is going on, then please keep the noise
> down.  Next time please have some credablity when you attempt to make
> grand pontifications of code quality in Linux.  Lastly you were not to be
> a target for everyones entertainment but this is where you have come.

I'm sorry if the subject set you off.. what I should have written is
propably "ATA hard disk access slows down my system", but I was tired and
had previously been reading "comp.sys.ibm.pc.games.space-sim".

Also, I'm not meaning to sound important or anything with my sig. Maybe I
should change it? Hmm...

>
> Regards,
>
> Andre Hedrick
> Linux ATA Development
> Linux Disk Certification Project

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  Linux developer / Ignorant excuse for a human /
|  Ranting bastard / Swede


