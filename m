Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSEVJLy>; Wed, 22 May 2002 05:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSEVJLx>; Wed, 22 May 2002 05:11:53 -0400
Received: from mx2.mail.ru ([194.67.57.12]:1030 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id <S316899AbSEVJLw>;
	Wed, 22 May 2002 05:11:52 -0400
Date: Wed, 22 May 2002 13:12:10 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/port BUG and possible workaround
Message-Id: <20020522131210.5bae244b.nickols_k@mail.ru>
In-Reply-To: <3CEB4E43.5020203@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "!)vNpG9Y185-O2<eVyyJ~0qRR)*F6cqQ~4M1t&#ySm7U`/2^cu]w9ue;1a%V[PI9rrNv&) 'SWe=9[7:A?Ku[t,{?*J*`Wfay.pSsvyg2)DXl.M%;-yrV0)pL;(yzPs#(8M|dYuB3%(/}#
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.smnd36nSrVi8H+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.smnd36nSrVi8H+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello, Martin!

On Wed, 22 May 2002 09:52:35 +0200 you wrote:

> Uz.ytkownik Nick Kurshev napisa?:
> 
> ...
> 
> > 800=inl(CFC)
> > 2. Wrong log with using of /dev/port:
> 
> ...
> 
> > But it seems that nobody uses this device. Then what is goal
> > of implementing of this device?
> 
> Basically the goal is that contrary to some silly /proc
> stuff which is "en vouge" nowadays you have the ability to
> controll port access by using normal user permission control
> semantics of unix file access permissions, by giving /dev/port
> a proper group and so on. This is legacy crap of course, since
But this device is unworking in general. It simply unusable for
programs which require 4-byte operations with ports.
As I wrote: outl() != 4*outb() same as inl() != 4*inb()
> the above goal can be reached by using a apache-suexec alike wrapper
> as well... even with more fine grained resolution of access controll.
> 
Maybe after fixing these flaws it will be usable but not for now.


Best regards! Nick

--=.smnd36nSrVi8H+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE862DsB/1cNcrTvJkRArC/AKCQX88a0yxx9q53HObJAW4ICU8A7ACgwxnc
bYmpKFnu2qzrn+iDw/PSkrE=
=3PCW
-----END PGP SIGNATURE-----

--=.smnd36nSrVi8H+--

