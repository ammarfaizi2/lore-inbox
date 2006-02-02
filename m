Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWBBW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWBBW56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWBBW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:57:58 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:26856 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750950AbWBBW55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:57:57 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 08:54:22 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe>
In-Reply-To: <1138916079.15691.130.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1552171.yEgq7vIiOl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602030854.28201.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1552171.yEgq7vIiOl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 03 February 2006 07:34, Lee Revell wrote:
> On Thu, 2006-02-02 at 13:27 -0800, Andrew Morton wrote:
> > And having them separate like this weakens both in the area where
> >   the real problems are: drivers.
>
> Which are the worst offenders, keeping in mind that ALSA was recently
> fixed?

USB used to be a big problem, but Greg and the other USB guys are doing gre=
at=20
work, and it has improved a lot since 2.6.12.

The worst areas now are video drivers, particularly where DRI and/or Nvidia=
=20
are involved.

=46ollowing that there are some is frequently used hardware such as firewir=
e and=20
hardware that people try to suspend less often, such as scsi. ACPI, cpufreq=
=20
and the like have accounted for a share of problems in the past, but are=20
generally ok now.

Hope that helps!

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1552171.yEgq7vIiOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4o2kN0y+n1M3mo0RApm8AJ9WSaBv8Syf5rmiYh1yIY044rhXCgCffSKq
GuU/U9bcwFvSeh+aM8ezgFE=
=2N7Q
-----END PGP SIGNATURE-----

--nextPart1552171.yEgq7vIiOl--
