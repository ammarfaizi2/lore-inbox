Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283208AbRK2NcV>; Thu, 29 Nov 2001 08:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283224AbRK2NcL>; Thu, 29 Nov 2001 08:32:11 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:8308 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283208AbRK2NcF> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 08:32:05 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: axboe@suse.de
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Thu, 29 Nov 2001 14:33:42 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128153718.D23858@suse.de> 
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011129133206Z283208-17408+23721@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 29. November 2001 14:26 schrieben Sie:
> Am Mittwoch, 28. November 2001 15:37 schrieben Sie:
> > On Wed, Nov 28 2001, Jens Axboe wrote:
> > > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > >
> > > > Am Mittwoch, 28. November 2001 14:58 schrieben Sie:
> > > > > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > > Hash: SHA1
> > > > > >
> > > > > > Hi Jens,
> > > > > > your patch doesn't work for ide-scsi
> > > > > > I get this oops when trying to mount a CD:
> > > > >
> > > > > [oops in sr_scatter_pad]
> > > > >
> > > > > Hmm ok, and 2.5.1-pre1 works for you right?
> > > >
> > > > Yes it works very well
> > >
> > > Ok, thanks for confirming that. Going to take a look at it now.
> >
> > Does this work for you? Apply on top of what you already have.
>
> OK it does work BUT
> when I read audio data from a CD it reads the first ~20 MB and then it
> doesn't write anything on hdd.
> When I try to play an audio CD with the KDE CD player it crashes
> immediately 2.5.1-pre1 works fine and mounting/reading data CDs work, too
> Bye
But wait :)
I'll first test 2.5.1-pre3 + Alan's Patch + your sg-sr patch + your bio patch
Bye
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Bjk4vIHrJes3kVIRAuLmAJ9wVsXe/S93b5in+3CyPl1QodIKPACeLtkx
qjsXfuO+dOOGPYoyyjgLfSE=
=lp5q
-----END PGP SIGNATURE-----
