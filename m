Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUE0RTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUE0RTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUE0RTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:19:16 -0400
Received: from hostmaster.org ([212.186.110.32]:8576 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264625AbUE0RRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:17:40 -0400
Subject: AMD64: IDE performance woes
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TfiKkqoaJjp1vZpsP8Ze"
Message-Id: <1085678259.3374.7.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 19:17:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TfiKkqoaJjp1vZpsP8Ze
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

It seems that IDE performance is severely degraded on AMD64:

hdparm -t timings
2.4.25/i386:  54.13MB/s
2.6.6/x86_64: 31.4MB/s

Board is a Tyan Thunder K8W s2885 with an AMD8111 controller
IDE device parameters are the same (hdparm -a8 -c1 -d1 -m16 -u1)

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Everybody wants to go to heaven, but nobody wants to die.

--=-TfiKkqoaJjp1vZpsP8Ze
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQLYis2D1OYqW/8uJAQKtnAf/fe2Zzp50EkWB979RE/u1hzxXIVur8/9J
nkKRZ8VqR1Hzqrmsp8wSlNfzVi99Ba0jlAAS4wlGPp/bbnesbh5K+Xn/RKKelYpr
YkjASEXnPoG2lS0UrvjvT+QCCbgCzgrnhabU9Epf2kvUQfNHK4JzmJ1W7Mno4kdO
60AzudBfC533KVUSTEcLjOT4ALrIRNtiHD/DuxPTg5IGTubwLKLnvUuR46VSNRlC
CAjkMVYeDNpLXnVxaqJMdi+YQCWfhsKs9rXCLDwldbYP2rMl00FJHc8J2+9BICbi
RoiHVN4R6wVxj5YqWwF/j+hH1i8Q28gr1O5YjU14e1laaUL0ac4bYA==
=ppZ2
-----END PGP SIGNATURE-----

--=-TfiKkqoaJjp1vZpsP8Ze--

