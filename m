Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUADTY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUADTY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:24:27 -0500
Received: from alhya.freenux.org ([213.41.137.38]:29140 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S262355AbUADTYZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:24:25 -0500
From: Mickael Marchand <marchand@kde.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Update : Silicon Image 3114, 4 ports support
Date: Sun, 4 Jan 2004 20:24:17 +0100
User-Agent: KMail/1.5.94
References: <200401041413.20573.marchand@kde.org> <20040104192048.GA17638@gtf.org>
In-Reply-To: <20040104192048.GA17638@gtf.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "B. Gajdos" <brian@chem.sk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401042024.29421.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le Sunday 04 January 2004 20:20, vous avez écrit :
> On Sun, Jan 04, 2004 at 02:12:56PM +0100, Mickael Marchand wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi,
> >
> > Thanks to the info Brian provided, I was able to set up the 4 ports of
> > the sil3114.
> > Attached is the patch for sata_sil.c, tested on a 2.6.1-rc1-mm1 and
> > tested by Brian too.
> >
> > I used
> > if (ent->driver_data == sil_3114)   { ... }
> >
> > to ensure the 4 ports are probed only for sil3114 , I am not sure this is
> > the correct way to do it (so that sil3112 support is not broken). I guess
> > Jeff will review that :)
>
> Yeah, your patch looks good.  I assume you tested ports 3 and 4?
Brian tested them yes.
on my (remote) box, the ports appears in dmesg but have no disks connected.
Brian confirmed he can use his 4 drives with the patch.

Cheers,
Mik
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+GhhyOYzc4nQ8j0RAhpzAJ95KGcYQ0wJwPKQJWoIF90hY3dHPgCcDb64
L5O9Uu7TZDlQ8AoEoDTgqys=
=5nrB
-----END PGP SIGNATURE-----
