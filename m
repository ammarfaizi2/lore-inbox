Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDUMTx>; Sat, 21 Apr 2001 08:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbRDUMTo>; Sat, 21 Apr 2001 08:19:44 -0400
Received: from www.topmail.de ([212.255.16.226]:18344 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S132580AbRDUMT2>;
	Sat, 21 Apr 2001 08:19:28 -0400
Message-ID: <021601c0ca5d$4e3c0720$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: <Wayne.Brown@altec.com>, "Thomas Dodd" <ted@cypress.com>,
        "John Madden" <weez@freelists.org>,
        "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
        "Jesper Juhl" <juhl@eisenstein.dk>, "Dax Kelson" <dax@gurulabs.com>,
        "Aaron Lunansky" <alunansky@rim.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <86256A34.00808239.00@smtpnotes.altec.com>
Subject: Re: Current status of NTFS support
Date: Sat, 21 Apr 2001 12:19:23 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to all who offered suggestions, both on the list and privately.
Rather
> than answer them all individually, I'm going to respond in this one
message.
>
> Unfortunately the upgrade is not going to be done by me, but by our PC
support
> team.  Our laptops originally were set up with two FAT32 partitions:
a small
> one for Win98 and applications, and a large one for data files.  I
used FIPS to
> carve off most of the large one for a swap partition and an ext2
partition.
> Now, because of the larger space requirements of Win2000, they're
going to wipe
> out everything on the drives and start from scratch.  They'll be doing
all our
> laptops in a short period of time, and want to do all of them the same
way.
>
> >From everything I've been told here, it sounds like my best bet is to
try and
> talk them into replacing the two FAT32 partitions (which are
contiguous) with
> one big one and leave my Linux partitions alone.  That way I won't
have to deal
> with NTFS at all.  Fortunately, one of the PC support guys ought to be
> sympathetic; he runs Linux at home and has asked me for advice in
getting it set
> up on his laptop, too.  I'll see if I can talk him into doing my
machine
> differently from the others.  I have to be careful, though; my Linux
use at work
> is tolerated, but not (yet) encouraged, and I don't want to rock the
boat too
> much.
>
> Thanks again to everyone.
>
> Wayne

I would, if it goes all wrong, just copy all the stuff from NTFS over
network
to your home PC (linux boot floppy, NTFS r/o mount), use a windoze boot
floppy
to create FAT32 partitions, get a FAT32 NT boot sector from somewhere
(or use
the Recovery Console which I find great) and copy it back over network.
This should run without any serious problems.

-mirabilos


