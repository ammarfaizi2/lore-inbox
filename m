Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTIPTAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTIPTAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:00:54 -0400
Received: from h80ad2599.async.vt.edu ([128.173.37.153]:53136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262052AbTIPTAw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:00:52 -0400
Message-Id: <200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum 
In-Reply-To: Your message of "Tue, 16 Sep 2003 11:50:16 PDT."
             <3F675B68.8000109@eternal-systems.com> 
From: Valdis.Kletnieks@vt.edu
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo>
            <3F675B68.8000109@eternal-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-786628835P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2003 15:00:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-786628835P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Sep 2003 11:50:16 PDT, Vishwas Raman <vishwas@eternal-systems.com>  said:

> Can anyone out there tell me the algorithm to update the checksum 
> without having to recalculate it.

The canonical source is the RFCs:

1071 Computing the Internet checksum. R.T. Braden, D.A. Borman, C.
     Partridge. Sep-01-1988. (Format: TXT=54941 bytes) (Updated by
     RFC1141) (Status: UNKNOWN)

1141 Incremental updating of the Internet checksum. T. Mallory, A.
     Kullberg. Jan-01-1990. (Format: TXT=3587 bytes) (Updates RFC1071)
     (Updated by RFC1624) (Status: INFORMATIONAL)

1624 Computation of the Internet Checksum via Incremental Update. A.
     Rijsinghani, Ed.. May 1994. (Format: TXT=9836 bytes) (Updates
     RFC1141) (Status: INFORMATIONAL)

http://www.ietf.org/rfc/rfc1071.txt
http://www.ietf.org/rfc/rfc1141.txt
http://www.ietf.org/rfc/rfc1624.txt

--==_Exmh_-786628835P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Z13dcC3lWbTT17ARAvY9AKDFchcKYguAp8aMok67/g7DJ/jn8QCeP2J5
q1MyVygKydxXD2bbThwHdb8=
=RURg
-----END PGP SIGNATURE-----

--==_Exmh_-786628835P--
