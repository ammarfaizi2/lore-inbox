Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280457AbRKXXPr>; Sat, 24 Nov 2001 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280467AbRKXXPh>; Sat, 24 Nov 2001 18:15:37 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50816 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S280457AbRKXXPR>; Sat, 24 Nov 2001 18:15:17 -0500
Message-ID: <007901c1753d$b541ae80$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Alexander Viro" <viro@math.psu.edu>, "Robert Boermans" <boermans@tfn.net>
Cc: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0111241749320.6117-100000@weyl.math.psu.edu>
Subject: Re: 2.5.0 breakage even with fix?
Date: Sat, 24 Nov 2001 16:14:03 -0700
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

Al,

I am not seeing any more breakage with this fix with NWFS.

Jeff

----- Original Message -----
From: "Alexander Viro" <viro@math.psu.edu>
To: "Robert Boermans" <boermans@tfn.net>
Cc: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>; <linux-kernel@vger.kernel.org>
Sent: Saturday, November 24, 2001 4:03 PM
Subject: Re: 2.5.0 breakage even with fix?


>
>
> On Sun, 25 Nov 2001, Robert Boermans wrote:
>
> > If the filesystem is marked clean, does that mean that people with
> > journalling file systems are fscked? (since there might be no journal
entry
> > of what hasn't finished.)
>
> Well, if filesystem doesn't have a recovery tool that would allow forced
> check mode - you _are_ screwed.  As you will be again and again if you get
> memory corruption/driver bugs/fs bugs/RAID bugs/physical disk
problems/etc.
>
> Again, if filesystem trusts clear bit to the extent that you have no way
> to convince it that checks _are_ needed - it's unfit for any serious use.
> I suspect that by now everybody had learnt that much - that used to be
> a permanent source of problems with early journalling filesystems and
AFAIK
> all of them had been fixed since then.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

