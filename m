Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288981AbSBOMtO>; Fri, 15 Feb 2002 07:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBOMtD>; Fri, 15 Feb 2002 07:49:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:61013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288960AbSBOMsn>;
	Fri, 15 Feb 2002 07:48:43 -0500
Date: Fri, 15 Feb 2002 13:52:23 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-Id: <20020215135223.46af1b28.sebastian.droege@gmx.de>
In-Reply-To: <20020214192633.A2311@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de>
	<20020214180501.A1755@namesys.com>
	<20020214162232.5e59193b.sebastian.droege@gmx.de>
	<20020214172421.5d8ae63c.sebastian.droege@gmx.de>
	<20020214192633.A2311@namesys.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.l,Q?9srkYWhs2H"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.l,Q?9srkYWhs2H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On Thu, 14 Feb 2002 19:26:33 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Feb 14, 2002 at 05:24:21PM +0100, Sebastian Dröge wrote:
> 
> > reiserfsck --check said I have to do --rebuild-tree because of critical corruption (many "bad_leaf: block xxxxx has wrong order of items")...
> 
> these are 2.5.3 signs.
> 
> > after that I booted into 2.4.17. Everything works okay.
> > Then I booted 2.5.5-pre1 and the mysterious files are there again after starting GNOME. I've copied one file to another location but when I reboot into 2.4.17 the files and the copy are gone again...
> 
> But GNOME is working, right?
Yes GNOME works in 2.4.17... in 2.5.5-pre1 it works two but I have some problems...
> 
> > If you need one or two file names or the content of them just ask (They begin with an "^")... then I'll handcopy them ;)
> 
> I have a better approach.
> Just recreate them (by running GNOME in 2.5.5-pre1?) and then tar them up ;)
> Send the ersulting tar file to me.
Hey that would be to easy ;)
> 
> > The format of the partition is 3.6 and another partition with 3.5 format had no errors... Maybe this helps
> 
> So now problem only is that there are strange files after GNOME start, right?
> Do these files disa[[ear after you quit GNOME?
They don't disappear but I can't reproduce the behaviour anymore...
I've run reiserfsck --fix-fixable, it detects one error, fixes that and after reboot the files were gone in 2.4.17 AND 2.5.5-pre1
So the problem seems to be solved
Now I have another problem... If I start the gnome-terminal 9 of 10 times it hangs and bash doesn't start
I had this behaviour before the reiserfscks but I thought it has something to do with the files
2.4.17, again, runs without any problems
Maybe somebody can test if he can start gnome-terminal with 2.5.5-pre1

Bye
--=.l,Q?9srkYWhs2H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8bQSKe9FFpVVDScsRAjolAKDwUD3hw2xA9Msq1YIdwoujbDrNBACgwZgf
fqlXE3OY/4naN0d556Y10MY=
=Mlhw
-----END PGP SIGNATURE-----

--=.l,Q?9srkYWhs2H--

