Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbTIEOVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTIEOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:21:14 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:31643 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262826AbTIEOUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:20:23 -0400
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm6
Date: Fri, 5 Sep 2003 16:20:03 +0200
User-Agent: KMail/1.5.3
Cc: Jan Ischebeck <mail@jan-ischebeck.de>
References: <1062758896.2085.19.camel@JHome.uni-bonn.de>
In-Reply-To: <1062758896.2085.19.camel@JHome.uni-bonn.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_XuJW/VxDXF+BTBg";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309051620.07380.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_XuJW/VxDXF+BTBg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

I have the same X problem on mm6. I use a Radeon 8500, Debian/Sid.

On Friday 05 September 2003 12:48, Jan Ischebeck wrote:
> On Friday 05 September 2003 16:59, Andrew Morton wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4=
/2
>.6.0-test4-mm6/
>
>
> Hi Andrew,
>
> Some first impressions:
>
> 1. swsusp works great (Thinkpad R40 2722)
>
> 2. X11R6 won't start anymore, it fails with a strange
> Fatal server error:
> xf86OpenConsole: VT_GETMODE failed
> I can't find a reason for that in the changelog.
>
> 3. The oss mixer emulation doesn't load correctly, I get the following
> messages in the syslog, f.e. after a "modprobe snd-mixer-oss":
>
> snd: Unknown parameter `device_mode'
> snd_mixer_oss: Unknown symbol snd_info_register
> snd_mixer_oss: Unknown symbol snd_info_free_entry
> snd_mixer_oss: Unknown symbol snd_info_get_str
> snd_mixer_oss: Unknown symbol snd_unregister_oss_device
> snd_mixer_oss: Unknown symbol snd_ctl_find_id
> snd_mixer_oss: Unknown symbol snd_register_oss_device
> snd_mixer_oss: Unknown symbol snd_card_file_add
> snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
> snd_mixer_oss: Unknown symbol snd_iprintf
> snd_mixer_oss: Unknown symbol snd_kcalloc
> snd_mixer_oss: Unknown symbol snd_cards
> snd_mixer_oss: Unknown symbol snd_ctl_notify
> snd_mixer_oss: Unknown symbol snd_oss_info_register
> snd_mixer_oss: Unknown symbol snd_kmalloc_strdup
> snd_mixer_oss: Unknown symbol snd_info_create_card_entry
> snd_mixer_oss: Unknown symbol snd_card_file_remove
> snd_mixer_oss: Unknown symbol snd_info_unregister
> snd_mixer_oss: Unknown symbol snd_info_get_line
>
> Could be connected with
>
> > +sound-remove-duplicate-includes.patch
> > +kernel-remove-duplicate-includes.patch
> >
> > janitorial work
>
> 4. Powerdown via ACPI still doesn't work (broken since -test2 or -test1)
>
> Thanks for the great work.
>
> Jan
>
> (Please CC me on reply)

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_XuJW/VxDXF+BTBg
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/WJuX4q3E2oMjYtURAh59AJsGddXbCKZjfs8ab/gtng8fLnYgUQCff8EP
ZWmrFvkoHaU1uLegxp4YXSk=
=SqDS
-----END PGP SIGNATURE-----

--Boundary-02=_XuJW/VxDXF+BTBg--

