Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbUKVR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbUKVR0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUKVRYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:24:52 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:55179 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262205AbUKVRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:19:03 -0500
Date: Mon, 22 Nov 2004 18:18:55 +0100
From: Martin Waitz <tali@admingilde.org>
To: Zan Lynx <zlynx@acm.org>
Cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20041122171855.GO19738@admingilde.org>
Mail-Followup-To: Zan Lynx <zlynx@acm.org>, Amit Gud <amitgud1@gmail.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <2c59f00304112205546349e88e@mail.gmail.com> <20041122143720.GL19738@admingilde.org> <1101137642.15949.4.camel@titania.zlynx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <1101137642.15949.4.camel@titania.zlynx.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 22, 2004 at 08:34:02AM -0700, Zan Lynx wrote:
> > The kernel already provides all methods that are neccessary to do that.
> > So there is no need to implement it in the kernel.
>=20
> There are already several things in filesystems that don't strictly
> belong inside the kernel.  A filesystem could be implemented quite well
> as a user-space daemon that sat on top of the block device and
> communicated via sockets or shared memory just like an X server.

this is quite different.
As you need to enforce security policies when accessing the block
device, you have to move the filesystem into its own daemon.
You cannot do it in a library.
It is irrelevant for the application weather the fs resides in a
separate daemon or in the kernel itself.

But support of different views on files is something different.
You can do that in a library, you only need an interface that is
capable of storing your data. The kernel already provides that
interface.

--=20
Martin Waitz

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQFBoh9+j/Eaxd/oD7IRAkcrAJiTXhA9EboV6YlpkwDy/hmTqBLJAJ0flYlw
sSl9Fe0+1Gq4WZCYGkb5cg==
=J40Q
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
