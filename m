Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTJUPxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJUPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:53:41 -0400
Received: from 24-216-47-96.charter.com ([24.216.47.96]:2692 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263120AbTJUPxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:53:39 -0400
Date: Tue, 21 Oct 2003 11:53:37 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test8 and HIGMEM = segfaults and panics?
Message-ID: <20031021155337.GF2617@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I'm running a dual-athalon system.  When I compiled the 2.6.0-test8 kernel I
enabled HIGHMEM for 4 Gigs as I'm at 1.5G now and planning on purchasing
an additional 512Meg DIMM next weekend (yeah, should have with the
1.5Gig).

At any rate the box comes up just fine and runs for a while but once the
memory is in use for a few hours and seems to exceed 220+ Megs about any
command I execute will Segfault and the kernel has panic'd twice
(couldn't read the whole oops).

I backed out the HIGHMEM and left it at 1.5Gigs and it seems to be
running fine again.

I poked around the archives and couldn't find anything in particular
related to this.  Anyone seen anything similar, known bug I've missed?

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

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lVaB8+1vMONE2jsRAvTyAJ0SzlYFgvPWfO/7oti3+EBLTFvTQQCeIOao
lYg2ad8sT8LXQlu5UOi5JQI=
=YHLw
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
