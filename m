Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbUC3LeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUC3LeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:34:05 -0500
Received: from ns.suse.de ([195.135.220.2]:5088 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263615AbUC3LeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:34:01 -0500
Date: Tue, 30 Mar 2004 10:13:01 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330081301.GA3820@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org> <20040329124421.GB24370@suse.de> <1080565536.3570.4.camel@laptop.fenrus.com> <20040329130850.GD24370@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20040329130850.GD24370@suse.de>
X-Operating-System: Linux 2.6.4-3-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2004 at 03:08:50PM +0200, Jens Axboe wrote:
> Indeed, it would be best to keep the read-ahead window at least a
> multiple of the max read size. So you don't get the nasty effects of
> having a 128k read-ahead window, but device with 255 sector limit
> resulting in 124KB + 4KB read.

Any work underway to implement this?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAaSwNxmLh6hyYd04RApgGAKDFfuNj+INa5S98k+Wrn1ZK91HDHwCfRslH
C48Mrdz8sbXQMd8iR25ROY0=
=4E/Z
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
