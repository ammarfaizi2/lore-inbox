Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315344AbSDWUjf>; Tue, 23 Apr 2002 16:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315343AbSDWUjb>; Tue, 23 Apr 2002 16:39:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15503 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315333AbSDWUjF>;
	Tue, 23 Apr 2002 16:39:05 -0400
Date: Mon, 22 Apr 2002 00:17:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Sean Reifschneider <jafo@tummy.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
Message-ID: <20020422001720.H155@toy.ucw.cz>
In-Reply-To: <20020420212833.G2866@tummy.com> <5.1.0.14.2.20020421113007.04012810@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Don't ask me, I'm not a user, I have just seen the patch submissions, and
> > >I just want to get real user feedback before I'd merge a new "extended
> > >nbd".
> >
> >I haven't used enbd, because the site was down the weekend I was evaluating
> >the alternatives...  I did try NBD and DRBD, however.  My experience was
> >that enbd could hardly be worse than nbd, for the following reasons:
> >
> >    The nbd server software referenced in the Configuration documentation
> >    (the only I was able to find, and that only after some digging), would
> >    fail rather quickly because the remote kernel would send a request much
> >    larger than the server was expecting.
> 
> Indeed. The source code reference in th Configuration documentation is very 
> much out of data and completely broken for anything that requires 64 bit 
> sizes on a 32 bit architecture.

Can you submit patch to fix that docs? It should point to sourceforge..

> This is all fixed now (I know because I shared your frustration and went 
> and fixed it myself (-:), if you want to get a properly working version 
> which exhibits no problems under very intensive i/o on a 15GiB partition 
> over a 100MBit lan just go to http://sf.net/projects/nbd/ and get the 
> latest version from CVS or download the new 2.0 release tarball.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

