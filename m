Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVGZFLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVGZFLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGZFLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:11:35 -0400
Received: from adsl-68-248-193-223.dsl.klmzmi.ameritech.net ([68.248.193.223]:25868
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S261623AbVGZFJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:09:36 -0400
From: tabris <tabris@tabris.net>
To: Puneet Vyas <vyas.puneet@gmail.com>
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
Date: Tue, 26 Jul 2005 01:09:20 -0400
User-Agent: KMail/1.7.1
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org> <42E5927B.20506@gmail.com>
In-Reply-To: <42E5927B.20506@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6131753.5pPa2rdn8g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507260109.31579.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6131753.5pPa2rdn8g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 25 July 2005 9:31 pm, Puneet Vyas wrote:
> Alejandro Bonilla wrote:
> > Puneet Vyas wrote:
> >> PS : I am not even sure if I am "allowed" to pull out the writer
> >> like this. Am I supposed to "stop" the device first or something?
> >
> > You are supoused to unmount the volume. Try it. umount /dev/cdrom ?
> > Make sure that is it not in use, then unload it.
> > New versions of gnome and so have the option to right click the
> > loaded device and then to unmount.
> >
> > It should never hang. Does it hang with the floppy when removed?
>
> 1. When I did umount /dev/cdrom it says - "umount: /dev/hdc is not
> mounted (according to mtab)"
	at present, you cannot unmount a device, you have to unmount the=20
mountpoint. Although 'unmount by device' might be a useful feature, it=20
isn't currently supported.
	it probably is something like /mnt/cdrom. however, this varies by=20
distro and other factors.
> 2. Yes
>
> Thanks,
> Puneet

=2D-=20
* Overfiend ponders doing an NMU of asclock, in which he simply changes  =20
the extended description to "If you bend over and put your head between  =20
your legs, you can read the time off your assclock."
<doogie> Overfiend: go to bed.

--nextPart6131753.5pPa2rdn8g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBC5cWLgbFCivvqDfQRAo+BAJ9Volg2Q2v47DpOt/rwFYZ8VK+grwCgkmhc
XKKv8cjuRNHJmviAKRcW8dQ=
=GL1q
-----END PGP SIGNATURE-----

--nextPart6131753.5pPa2rdn8g--
