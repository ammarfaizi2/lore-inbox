Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSEVNuR>; Wed, 22 May 2002 09:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSEVNuQ>; Wed, 22 May 2002 09:50:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:10977 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313698AbSEVNuO>;
	Wed, 22 May 2002 09:50:14 -0400
Date: Wed, 22 May 2002 15:50:00 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: padraig@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-Id: <20020522155000.2f0791f4.sebastian.droege@gmx.de>
In-Reply-To: <3CEB8F74.7050804@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="3=.0bx)+9j+tJ:76"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--3=.0bx)+9j+tJ:76
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2002 14:30:44 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

> Uz.ytkownik Padraig Brady napisa?:
> > Martin Dalecki wrote:
> > 
> >> Remove support for /dev/port altogether.
> > 
> > 
> > FYI:
> > 
> > [root@pixelbeat padraig]# find /bin /usr/bin /lib /sbin /usr/sbin 
> > /usr/lib -maxdepth 1 -type f -perm +111 | xargs grep -l "/dev/port"
> > /sbin/hwclock: util-linux
> > /sbin/kbdrate: util-linux
> > /bin/watchdog: ;-)
> 
> Let's have a closer look.
> 
[snip]
> 
> You can see from the above that the code in question
> is accessing /dev/port only for the Jensen architecture...
This is util-linux 2.11n on x86:

slomosnail:~# kbdrate 
Cannot open /dev/port: No such file or directory

slomosnail:~# hwclock 
Wed May 22 15:48:50 2002  -0.460607 seconds

Bye
--3=.0bx)+9j+tJ:76
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE866IPe9FFpVVDScsRApC+AKCPL5RrluaWUGh3SWJ6838UMLJjLACg4p7Y
6/lIAHUoFTIy80qXhk8Y1c8=
=b+sz
-----END PGP SIGNATURE-----

--3=.0bx)+9j+tJ:76--

