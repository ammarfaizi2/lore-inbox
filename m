Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBORYr>; Thu, 15 Feb 2001 12:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBORYh>; Thu, 15 Feb 2001 12:24:37 -0500
Received: from md.aacisd.com ([64.23.207.34]:50703 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S129242AbRBORY1>;
	Thu, 15 Feb 2001 12:24:27 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D671897@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: linux-kernel@vger.kernel.org
Subject: RE: aic7xxx (and sym53c8xx) plans
Date: Thu, 15 Feb 2001 12:19:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I must say, after I saw this post, I tried out the latest driver for my own
purposes. 

This really improved the performance of my dual PIII-866 w/512MB Ram and
AIC7899 scsi.
I have a couple of cheetah drives that I am writing data that I get off of
an ATM card.(about 12-14 MB/sec rate).

This has significantly lowered the number of dropped packets on the ATM
read. 

I would suggest, if at all possible, putting this in the 2.4.2 kernel.

Nathan

-----Original Message-----
From: Chip Salzenberg [mailto:chip@valinux.com]
Sent: Wednesday, February 14, 2001 9:20 PM
To: Matthew Jacob
Cc: Wakko Warner; Alan Cox; J . A . Magallon; linux-kernel
Subject: Re: aic7xxx (and sym53c8xx) plans


According to Matthew Jacob:
> See http://www.freebsd.org/~gibbs/linux.

Here at VA we're already using Jason's driver -- it works on the Intel
STL2 motherboard, while Doug's driver doesn't (or didn't, a month ago).

While we're discussing SCSI drivers, I'd also like to put in a good
word for the Sym-2 Symbios/NCR drivers from Gerard Roudier:

    ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/

Joe-Bob says: "Check it out."
-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
