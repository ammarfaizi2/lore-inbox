Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136247AbRDVSR4>; Sun, 22 Apr 2001 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136256AbRDVSRq>; Sun, 22 Apr 2001 14:17:46 -0400
Received: from m2ep.pp.htv.fi ([212.90.64.98]:25360 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S136247AbRDVSRn>;
	Sun, 22 Apr 2001 14:17:43 -0400
Message-ID: <000701c0cb58$70373240$6786f3d5@pp.htv.fi>
From: "Ville Holma" <ville.holma@pp.htv.fi>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14r6WZ-0004XM-00@the-village.bc.nu>
Subject: Re: a way to restore my hd ?
Date: Sun, 22 Apr 2001 21:17:05 +0300
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

Thank You everybody who helped me solve the problem. I found a working
back-up of the superblock at -b 32768 and was able to save all of my
important work from the harddrive. The filesystem was however badly
corrupted and lots of other files were truncated after e2fsck had finished.
So I ended up just re-installing my linux distribution but didn't loose any
valuable work. Lucky me.

So, again, Thank You all for the great help I received. You know who you
are.

Ville


> > The memory I had was however somehow corrupt and after I got my new
system
> > booted up and used it a little it became shaky and then locked hard and
I
> > could do nothing but reset it. I suppose this was caused by the
> > malfunctioning memory but I can't be sure, I know there has been
problems
> > with the via chipset also.
>
> Nod
>
> > debian:~# e2fsck /dev/hdb7
> > e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> > Corruption found in superblock.  (frags_per_group = 2147516416).
>
> Try e2fsck -b 8193 /dev/hdb7
>
> (and 16384, 32768)
>
> This is a backup copy of the superblock.
>

