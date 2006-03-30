Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWC3DDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWC3DDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWC3DDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:03:04 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:39093 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751228AbWC3DDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:03:01 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 13:01:37 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ashok.raj@intel.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
References: <20060329220808.GA1716@elf.ucw.cz> <20060329161354.3ce3d71b.akpm@osdl.org> <200603301018.36654.ncunningham@cyclades.com>
In-Reply-To: <200603301018.36654.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1356306.72zGQn8tPD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603301301.42922.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1356306.72zGQn8tPD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sam.

A bunch of us were discussing an issue this morning, and came across the=20
problem that selects don't seem to be enforced in choice menus. To give a=20
concrete example, a couple of us tried to make CONFIG_SOFTWARE_SUSPEND sele=
ct=20
CONFIG_X86_GENERICARCH. After enabling SOFTWARE_SUSPEND, we want back to th=
e=20
subarchitecture menu, and could still select other subarches. Is this by=20
design?

Regards,

Nigel

--nextPart1356306.72zGQn8tPD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEK0oWN0y+n1M3mo0RAnm1AJ4kFtNtgSYUlhwDuaq7VRYRBfgNbQCgvAnK
zQnpJc1+UVFeTJGn2ukFbBc=
=KCRm
-----END PGP SIGNATURE-----

--nextPart1356306.72zGQn8tPD--
