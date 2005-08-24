Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVHXAd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVHXAd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVHXAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:33:59 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:26812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932513AbVHXAd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:33:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=MzBDwS6FbOfhXimxwiixXPT8Y/mN0YU2lRFkzDovKg1OusoPZVt+JCH+B9DOmTLzHjTfELovfB539bAenhnuQswtyFSlC8wgZUoVomF6zTRLgelGkPx274eJp9azgwkPFJQJusj3PPdyO4NtYs0f82h5PfYbdcsjy+jO/XMMmRM=
From: Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?= 
	<rafael.espindola@gmail.com>
To: linux-kernel@vger.kernel.org, itautec@las.ic.unicamp.br,
       ltc@las.ic.unicamp.br
Subject: conexant modem driver for 2.6.12
Date: Tue, 23 Aug 2005 21:28:37 -0300
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart80350235.FDzRJ9Hdq9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508232128.43099.rafael.espindola@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart80350235.FDzRJ9Hdq9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have ported the Conexant modem driver to the 2.6.12 kernel. The port is=20
based on the lattest BSD/GPL version that I could find: 5.03.27.

To make the port easier, I have considered only the model that I have: the=
=20
"HSF 56k HSFi Modem (rev 01)".

The port is still quite a mess, but it can be dowloaded from:
http://www.las.ic.unicamp.br/~espindola/modem.tar.bz2

Note that, since I don't know if I have permission to do so, this archive d=
oes=20
not includes the binary files hsfbasic2.O and hsfengine.O. These files must=
=20
be moved from a copy of the 5.03.27 driver.

If you have a modem that is not supported by this port, but works with=20
5.03.27, I would love to hear from you. I would also like to hear any=20
comments you may have. Please keep in mind that there is a lot of cleaning =
to=20
be done...

I hope that this will be usefull.
Rafael  =C1vila de Esp=EDndola

--nextPart80350235.FDzRJ9Hdq9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDC786LlrfGJ8JUHwRAhaSAJ4sWT0YgzO48X/aKkw06jFB2nSNJACgpbPf
kYj5PnqVZ5J2h87kRiBYgOs=
=mzAv
-----END PGP SIGNATURE-----

--nextPart80350235.FDzRJ9Hdq9--
