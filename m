Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUJKQdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUJKQdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUJKQbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:31:23 -0400
Received: from darwin.snarc.org ([81.56.210.228]:35474 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S269148AbUJKPuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:50:15 -0400
Date: Mon, 11 Oct 2004 17:49:50 +0200
To: Vitez Gabor <vitezg@niif.hu>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: forcedeth: "received irq with unknown events 0x1"
Message-ID: <20041011154950.GA22553@snarc.org>
References: <20041011145104.GA9494@swszl.szkp.uni-miskolc.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20041011145104.GA9494@swszl.szkp.uni-miskolc.hu>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2004 at 04:51:04PM +0200, Vitez Gabor wrote:
> Hi,
>=20
> my forcedeth driver said:
>=20
> eth1: received irq with unknown events 0x1. Please report

Hi,

In latest 2.6, the 0x1 event is handle as IRQ_RX_ERROR.
the 2.4 driver is not synced with 2.6 and apparently a bit old.
you may consider a backport of the 2.6 driver to the 2.4 to fix the problem.

--=20
Tab

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBaquezKe/MInoaQARAhVXAJ473KbX60UoF+SETxFki7y7diz/jQCeNRKp
FzsArhNZ/NFwrQs7p32ssrU=
=hXFP
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
