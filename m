Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283250AbRK2OgC>; Thu, 29 Nov 2001 09:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283254AbRK2Ofx>; Thu, 29 Nov 2001 09:35:53 -0500
Received: from pop.gmx.net ([213.165.64.20]:29073 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283250AbRK2Ofp> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 09:35:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Thu, 29 Nov 2001 15:37:07 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011129140517.8650E1E122@Cantor.suse.de> <20011129152310.L10601@suse.de>
In-Reply-To: <20011129152310.L10601@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011129143545Z283250-17408+23743@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 29. November 2001 15:23 schrieben Sie:
> On Thu, Nov 29 2001, Slo Mo Snail wrote:
> > > But wait :)
> > > I'll first test 2.5.1-pre3 + Alan's Patch + your sg-sr patch + your bio
> > > patch Bye
> >
> > Hmm it works :)
>
> Just to confirm -- 2.5.1-pre3 + Alan's patch + my bio-pre3-1 patch,
> right? pre3 already contains the sg-sr part.
>
> > I'll test some more things with my CD drives ;)
> > Maybe I'll find some bugs
>
> Please do :)
Sorry my mistake
I've meant this patch: 
http://kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre3/bio-pre3-1.gz

So it's 2.5.1-pre3 + Alan's patch + bio-pre3-1 + the patch you've posted 
after the 2.5.1-pre3 don't-use mail

There were no failures while patching so I think this patches are compatible 
each other ;)

And it works well... no data corruption, no oopses, no nothing ;)
Later the day I'll test burning a CD
Bye
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BkgVvIHrJes3kVIRAiQQAKCG0efeie+bKhbKe+BHXaI4XCCSuACfS7T/
806yy00KSYP+zID3ijLskfQ=
=idKY
-----END PGP SIGNATURE-----
