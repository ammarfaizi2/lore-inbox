Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291756AbSBNQVD>; Thu, 14 Feb 2002 11:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291762AbSBNQUz>; Thu, 14 Feb 2002 11:20:55 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:50874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291756AbSBNQUl>;
	Thu, 14 Feb 2002 11:20:41 -0500
Date: Thu, 14 Feb 2002 17:24:21 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-Id: <20020214172421.5d8ae63c.sebastian.droege@gmx.de>
In-Reply-To: <20020214162232.5e59193b.sebastian.droege@gmx.de>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de>
	<20020214180501.A1755@namesys.com>
	<20020214162232.5e59193b.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.:lDkbTA?4/uCct"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:lDkbTA?4/uCct
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On Thu, 14 Feb 2002 16:22:32 +0100
Sebastian Dröge <sebastian.droege@gmx.de> wrote:

> On Thu, 14 Feb 2002 18:05:01 +0300
> Oleg Drokin <green@namesys.com> wrote:
> 
> > Hello!
> > 
> > On Thu, Feb 14, 2002 at 03:57:16PM +0100, Sebastian Dr?ge wrote:
> > 
> > > after starting GNOME with 2.5.5-pre1 with reiserfs on the root partition I get several funny-named files in ~/.gnome/accels and I can't start some programms anymore... When I reboot into 2.4.17 again everything works right and this files are gone again
> > 
> > Hm. I was not able to run 2.5.5-pre1 with reiserfs support without patch
> > attached at all.
> > 
> > > This only happens with any kernel since 2.5.4-pre* or so and it happens everytime I try to start GNOME under such kernel.
> > 
> > Have you tried to run reiserfsck on your partition after 2.5.4-pre1
> > Run reiserfsck and never use 2.5.4-pre1 or earlier 2.5 kernels.
> Thanks I'll try that
> *bootingfromcdandrunningreiserfsck* ;)
> Bye

Ok...
reiserfsck --check said I have to do --rebuild-tree because of critical corruption (many "bad_leaf: block xxxxx has wrong order of items")...
after that I booted into 2.4.17. Everything works okay.
Then I booted 2.5.5-pre1 and the mysterious files are there again after starting GNOME. I've copied one file to another location but when I reboot into 2.4.17 the files and the copy are gone again...
If you need one or two file names or the content of them just ask (They begin with an "^")... then I'll handcopy them ;)
The format of the partition is 3.6 and another partition with 3.5 format had no errors... Maybe this helps

I could build 2.5.5-pre1 without your patch from the last mail but for this try I have build the kernel with it
Bye
--=.:lDkbTA?4/uCct
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8a+S3e9FFpVVDScsRAomFAKCVwvUpufJhkYC2oNhA+RS/qHCebgCdGClD
UGUoJS1X0uFpmIZODI6WAPA=
=t6nk
-----END PGP SIGNATURE-----

--=.:lDkbTA?4/uCct--

