Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVEPSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVEPSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEPSB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:01:56 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:2949 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261775AbVEPSB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:01:28 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: linux-kernel@vger.kernel.org
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
Date: Mon, 16 May 2005 20:01:22 +0200
User-Agent: KMail/1.8
References: <200505161604.10881.trapni@gentoo.org> <4288D51D.8090401@pantasys.com>
In-Reply-To: <4288D51D.8090401@pantasys.com>
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1953702.zMjJWiU1r0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505162001.24431.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1953702.zMjJWiU1r0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 May 2005 7:15 pm, Peter Buckingham wrote:
> Christian Parpart wrote:
> > Has anyone a hint for my WHY this is happening and HOW I could get rid =
of
> > it?
>
> This is because there is a PCI memory hole of about 1GB of space on the
> x86_64 platform. Basically it overlays the address space of the RAM that
> you have.
>
> You can try to enable memory hoisting (it may be called software memory
> hole in your bios). This will try to remap you RAM above the 4GB
> boundary so that the PCI space and your RAMs address space do not
> conflict. Unfortunately, this does not work particularly well...

Yeah, ("software"/"hardware"/"disabled") has been the other dropdown list i=
n=20
my BIOS (i remember now;) however, it's been 'disabled' as I touched my hos=
t=20
first, and playing around didn't help *yet". although here, the BIOS=20
reference book just didn't talk about this area either.

I'll try once again, thx all ;)

Regards,
Christian Parpart.

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
 19:59:46 up 54 days,  9:06,  0 users,  load average: 0.66, 0.61, 0.61

--nextPart1953702.zMjJWiU1r0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCiN/0Ppa2GmDVhK0RAsdMAJ9thCxym2YXMDwrnBIkFaKI/q+zpwCeOG/1
Q4qe8a2ebYlMwdFPXtG1bd4=
=JI/+
-----END PGP SIGNATURE-----

--nextPart1953702.zMjJWiU1r0--
