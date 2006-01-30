Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWA3AeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWA3AeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWA3AeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:34:14 -0500
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:41870 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1751213AbWA3AeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:34:14 -0500
Message-ID: <43DD5EF6.4010709@poczta.fm>
Date: Mon, 30 Jan 2006 01:33:58 +0100
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Gordon <codergeek42@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: security capabilities on filesystems
References: <43DD1FB7.9050509@poczta.fm> <7e90c9180601291600w53186f19w767ddcaa46a61039@mail.gmail.com>
In-Reply-To: <7e90c9180601291600w53186f19w767ddcaa46a61039@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4EDF4B248A1293BF59C17151"
X-EMID: 73e87138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4EDF4B248A1293BF59C17151
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Peter Gordon wrote:

>>I've poke around for some information but all I got (was this lousy t-s=
hirt)
>>that there is no support for capablities stored on a filesystem. Howeve=
r, I'd
>>like to ask if there are any chances to see this feature soon.
>=20
> What do you mean exactly? Ext2 (and its journalled cousin, Ext3; I'm
> not certain of other filesystems) can both store POSIX-style Access
> Control Lists (ACLs) and SELinux labeling as part of the inode
> metadata.

Reiserfs, xfs and jfs too.

Yet they all can't store, or I don't know how to set it up, POSIX
capabilities for executables. Those like CAP_NET_RAW or CAP_SYS_RAWIO.
The former is useful for ping the latter (was?) for X11. I know that this=

functionality can be achived with SELinux but it's to havy-weight for me.=

I'd rather implement BSD seclevels and capabilities.

> Hope this helps.

I am afraid no :-(

Bye.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig4EDF4B248A1293BF59C17151
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD3V76NdzY8sm9K9wRAgH3AJwJi0tiP44DpZ5EfQaYU+tjwYxkEgCfUuRG
2T0dWF3lqEU0exZpHd906gU=
=VHgv
-----END PGP SIGNATURE-----

--------------enig4EDF4B248A1293BF59C17151--
