Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280798AbRKKEQ2>; Sat, 10 Nov 2001 23:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280890AbRKKEQT>; Sat, 10 Nov 2001 23:16:19 -0500
Received: from thor.hol.gr ([194.30.192.25]:50911 "HELO thor.hol.gr")
	by vger.kernel.org with SMTP id <S280798AbRKKEQD>;
	Sat, 10 Nov 2001 23:16:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Panagiotis Moustafellos <panxer@hol.gr>
Reply-To: panxer@hol.gr
To: Mike Fedyk <mfedyk@matchmail.com>, Ivanovich <ivanovich@menta.net>
Subject: Re: Compile problem 2.4.14 [SOLVED]
Date: Sun, 11 Nov 2001 06:17:02 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01111022150000.00265@gryppas> <01111023170400.01130@localhost.localdomain> <20011110152214.E446@mikef-linux.matchmail.com>
In-Reply-To: <20011110152214.E446@mikef-linux.matchmail.com>
MIME-Version: 1.0
Message-Id: <01111106170202.00720@gryppas>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yeap, it was make mrproper what i had to do to make
the headache go away! It didn't even cross my mind it could
be that simple..
Thanx all of you guys


> > > I am really getting a hard time compiling the 2.4.14..
> > > My current system has a 2.4.13 (by patching all the way
> > > from 2.4.9), so I patched the sources, yes after make clean,
> > > make menuconfig, and make dep ; make bzImage, I get this
> > > message (during the compilation of vmlinux )
> > >
> > > Could someone give me some instruction on what could be
> > > the problem, and hopefully, how to fix it?
> > > Thanks in advance
> >
> > too much patching can't be good...
> > you should get the sources of the 2.4.14 and you'll have less headaches
>
> If the patches are applied properly, and no rejects are noticed, then you
> should be able to patch as much as you want, and it will be the same as af
> downloading directly from kernel.org.
>
> Now, if there was a previous kernel compile, and then several patches
> applied, (say from 2.4.0 all the way up to 2.4.14...) then you'll probably
> have to run "make mrproper" as mentioned by Keith...
>
> If I've left anything out, please let me knwo...
>
> Mike


- --------
Panagiotis Moustafellos
(aka panXer)
- --------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77fu+bGyRbxX5XdQRAjMoAJ4z2icJJZZkdjgrE/J0HzPEAkPZ4QCeLkum
oVAHhjUWsKSa42d2NgBcpqw=
=6MQT
-----END PGP SIGNATURE-----
