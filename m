Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWG3O3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWG3O3S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWG3O3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:29:18 -0400
Received: from nsm.pl ([195.34.211.229]:3089 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750833AbWG3O3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:29:17 -0400
Date: Sun, 30 Jul 2006 16:29:09 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Generic battery interface
Message-ID: <20060730142909.GA11854@irc.pl>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com> <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com> <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com> <20060730085500.GB17759@kroah.com> <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2006 at 12:52:52PM +0300, Shem Multinymous wrote:
> Put otherwise:
> Q:Quick, which io scheduler is used by /dev/scd0?
> A: cat /sys/dev/$((0x`stat -c%t /dev/scd0`))/\
>                $((0x`stat -c%T /dev/scd0`))/queue/scheduler


 A2: cat /sys`udevinfo -n scd0 -q path`/queue/scheduler  ?

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEzMI1ThhlKowQALQRAjNAAKDXq3Xxet48vz/PWRvXdEz99ZH8rwCeKJv5
hwsOWxPUqliljVgiidQgL0M=
=kwX3
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
