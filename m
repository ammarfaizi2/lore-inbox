Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTFKIwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTFKIwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:52:31 -0400
Received: from smtp02.web.de ([217.72.192.151]:10002 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264208AbTFKIw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:52:29 -0400
Subject: can a process modify these proc filesystem informations?
From: Martin MAURER <martin.maurer@email.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iAXw5gZQTnpBuuEu1jRS"
Organization: 
Message-Id: <1055322395.830.11.camel@z439-033-17.raab-heim.uni-linz.ac.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 11:06:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iAXw5gZQTnpBuuEu1jRS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Please CC me in your replies. (not subscribed to the list)

I am developping a firewall application[1], that filters connections
(besides other informations) on the process which is sending/receiving
the packets. To get the corresponding process name I use the following
method:
1.) i get the ip/port from ip_queue
2.) i search for the inode in /proc/sys/tcp[udp]
3.) i search in /proc/xxx/fd/ for the inode
4.) i get the executeable name by examining /proc/xxx/fd/exe
xxx being all pids in /proc


I just wanted to know if it is possible for a non-root process to
modify:=20
- /proc/PID/exe
- /proc/PID/fd
- /proc/sys/tcp

ie: Is the infomation I get this way reliable or can it be faked.

greetings
Martin Maurer

[1] http://fireflier.sf.net

--=-iAXw5gZQTnpBuuEu1jRS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+5vEbXHsqb5Up6wURApd6AJ4piqmottbaIrLAQoVqzgy93jhlxQCgg4YX
jwxojWbl1xTGGljSAa29+oI=
=aU2b
-----END PGP MESSAGE-----

--=-iAXw5gZQTnpBuuEu1jRS--

