Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUAPTj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUAPTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:39:56 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:61906 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265740AbUAPTjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:39:51 -0500
Date: Sat, 17 Jan 2004 08:41:13 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: [PREVIEW] Announce: Software Suspend Core Patch 2.0 rc4.
To: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074282072.5328.52.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-6+nigrb48rcTSWQ8+RjB";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6+nigrb48rcTSWQ8+RjB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all.

Release candidate 4 is ready for you to test and now being uploaded to
Sourceforge. It should be used with the following updated version
specific patches, which are also now available:

- 2.4.21 revision 1
- 2.4.22 revision 1
- 2.4.23 revision 5.
- 2.4.24
- 2.6.1  revision 1

Changes since rc3A:

- Fixed issues with preemption resulting in 'bad: scheduling while
atomic' messages in 2.6.
- Lots of cleanups and new documentation in the code.
- Fixed broken automatic swapon/off support. Now also used in debug_info
proc entry.
- Preliminary SMP support for 2.4. 2.6 support is coming.
- LZF compression (thanks to Marc Lehmann) and readahead support.
Suspend and resume in half the time!
- Fixed long standing oops when aborting during writing the image
header. Thanks to Bernard Blackham.  (I would have done it eventually!)
- Serial port power management support (Thanks Michael Frank). MTRR support=
 converted to PM
support.
- Many other small fixes and improvements.

Further documentation is to be added and one minor quirk addressed, but cod=
ewise, I'm wondering if
this might be 2.0 by another name.

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-6+nigrb48rcTSWQ8+RjB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACD5YVfpQGcyBBWkRAjXlAKChlWOeozBFEw0ppvcdU6oVOpcmXwCgnksi
yaO53+V+Jy02Abjtqes8G3E=
=vTHO
-----END PGP SIGNATURE-----

--=-6+nigrb48rcTSWQ8+RjB--

