Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSBSGKf>; Tue, 19 Feb 2002 01:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSBSGKY>; Tue, 19 Feb 2002 01:10:24 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:46774 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289789AbSBSGKL>;
	Tue, 19 Feb 2002 01:10:11 -0500
Date: Tue, 19 Feb 2002 07:13:58 +0100
From: Sebastian =?ISO-8859-1?B?RHL2Z2U=?= <sebastian.droege@gmx.de>
To: Gustavo Noronha Silva <kov@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gnome-terminal acts funny in recent 2.5 series
Message-Id: <20020219071358.408b9a6d.sebastian.droege@gmx.de>
In-Reply-To: <20020218213917.60e4dd5c.kov@debian.org>
In-Reply-To: <3C719641.3040604@oracle.com>
	<20020218213917.60e4dd5c.kov@debian.org>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.,Y4heONC75,FXy"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.,Y4heONC75,FXy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Feb 2002 21:39:17 -0300
Gustavo Noronha Silva <kov@debian.org> wrote:

> On Tue, 19 Feb 2002 01:03:13 +0100
> Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
> 
> > Running Ximian-latest for rh72/i386, latest 2.5 kernels (including
> >   2.5.4-pre2, 2.5.4, 2.5.5-pre1).
> > 
> > Symptom:
> >    - clicking on the panel icon for gnome-terminal shows a flicker
> >       of the terminal window coming up then the window disappears.
> >      No leftover processes.
> > 
> > What works 100%:
> >    - regular xterm in 2.5.x
> >    - gnome-terminal in 2.4.x (x in .17, .18-pre9, .18-rc2)
> I noticed this problem also... it seems the problem lies on
> devpts, I enabled it on my 2.5.5pre1 build, mounting
> devpts with the options given on the "readme" file
> made gnome-terminal start on the second try, almost
> everytime
Hi,
I have the same problem here... I reported it in another thread (look at "Reiserfs Corruption in 2.5.5-pre1")
Maybe it's something with devpts but I enabled only devfs...
If you start the gnome-terminal from an xterm for example it starts but hangs before or shortly after loading bash
Sometimes gnome-terminal starts without problems but most trys it hangs
If you strace gnome-terminal you can see an endless loop doing some funny things (I have deleted the output but I'll post it later the day, including "ps axlwww" output)

Bye
--=.,Y4heONC75,FXy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8ce0pe9FFpVVDScsRAp38AJ9Y1kEZIWPoRTJva/mZ2MsESf6plwCfUoyq
UtuuJTU54qD030NSdhkbqVc=
=fNIU
-----END PGP SIGNATURE-----

--=.,Y4heONC75,FXy--

