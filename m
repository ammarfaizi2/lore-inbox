Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJOPUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTJOPUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:20:51 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:59086 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263396AbTJOPUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:20:49 -0400
Date: Wed, 15 Oct 2003 11:20:48 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Bad clock?  battery?
Message-ID: <20031015152048.GP9589@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlXFiQcSFG/a+HqU"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlXFiQcSFG/a+HqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



A system of mine just started producint this:

2003-10-15 07:00:19 kernel: set_rtc_mmss: can\'t update from 59 to 0


Apparant Cause :

potential problem in the hardware's real time clock (at least, as far as I
can tell from the messags.  The kernel is trying to update the hardware
clock with the correct time and getting errors)

I haven't been able to find much else yet.  Any chance this could be
caused by a dead/dying motherboard battery or is it likely the timeclock
is dying?  This should be a Tyan 2466 motherboard and one of about 50
identicle systems out in production and the only one producing this
error.

Thanks,
  Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--HlXFiQcSFG/a+HqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jWXQ8+1vMONE2jsRAkMoAKCfDmUurvgBJ+pP2EarQx7TzPK9+ACgwi+W
JO7y0wo0AOHSHmY8zoKqjLM=
=2IoJ
-----END PGP SIGNATURE-----

--HlXFiQcSFG/a+HqU--
