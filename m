Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272941AbTHPOTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272942AbTHPOTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:19:41 -0400
Received: from gate.in-addr.de ([212.8.193.158]:58000 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S272941AbTHPOTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:19:39 -0400
Date: Sat, 16 Aug 2003 16:18:15 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030816141815.GB25049@marowsky-bree.de>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL> <20030815212707.GR1027@matchmail.com> <16189.58517.211393.526998@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <16189.58517.211393.526998@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-08-16T18:00:21,
   Neil Brown <neilb@cse.unsw.edu.au> said:

> I think that for now you should assume tat lvm over raid0 (or raid0
> over lvm) simply isn't supported.  As lvm (aka dm) supports striping,
> it shouldn't be needed.

Can raid0 detect that it is being accessed via DM and 'fail-fast' and
refuse to ever come up?

This probably also suggests that the lvm2 and evms2 folks should refuse
to set this up in their tools...


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
SuSE Labs - Research & Development, SuSE Linux AG
=20
High Availabilty, n.: Patching up complex systems with even more complexity.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/Pj0mudf3XQV4S2cRApT+AJ4yYuS5k7/FjLIJ2mY1fXJsj7tk4QCfV6Fa
o/F9TGiHGYi5Z0Rt+5kY4Tk=
=D7F3
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
