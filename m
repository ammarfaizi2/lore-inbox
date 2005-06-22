Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVFVIWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVFVIWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVFVIST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:18:19 -0400
Received: from [213.69.232.60] ([213.69.232.60]:1796 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S262897AbVFVIOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:14:31 -0400
Date: Wed, 22 Jun 2005 10:15:20 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: reboo(RB_HALT_SYSTEM) / exiting init?
Message-ID: <20050622081520.GN2779@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

if I call reboot(RB_HALT_SYSTEM) and do _exit(0) after that
(from init), I get a kernel panic on one system (x86, 2.6.10)
and no kernel panic on another system (uml, 2.6.11.11).

a) What is the correct behaviour?
b) May I not _exit() as init after I called reboot() with
   RB_HALT_SYSTEM, RB_POWER_OFF or RB_AUTOBOOT?

Greetings,

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrkeFrOTBMvCUbrlAQLwfQ/+IIFhc4cecsivdETiSxeHpqwWYjYsfidI
i4VKyR7fZ42DnpgwuTMuK1iXWFg+EpdZcP/sFjpev23N0imiIX/2e9gJzFwHH2/6
AJuI2PAKFr98yFsha1QTEkxogCDa5FyeV8xLMQREsaOdOIHU5yalXSbkwbz1Bf3P
Ud/+7TScE5vNQJrGtyb4AsvFVyquLnUmTsT5iUxd9nUd/339YDqv6UJ2nm4KEpVb
CIi1mj7RyGVjpiMhE9ym5Ahj/ba+0zEVDkXgFGx1Qhod5eGZudQBjKMJTrao2B7h
Pgj4w8QoM772J3sQC7TZEyZgaQ9O/z8gUM5zgjvBdqy1hndGn2LagjTvngRZ3K3B
taTQv/jHu7P54z1Fp+PzXn9fQlkZXZvGUMlu0VrSxfRaBvqKQaoHKc6WqgsCsRT3
2fItwcLdDijz0MVnjb7JPMIn5bT4nMXUttIFCXXhwwT+yDzh2CKCtyxIgAum8iYV
UJhIYkAIr+gkfsVlPxCYe+cAugjYppewqxRfSUndn0DlHZXK6tpJOT2npAJq6ZK/
8oeLQ6gKOF6fPLzw4iJZ6UP06YfFyJ3Aqgy4N5nTYFPlqTOByDKXdCc4YtACTKlD
o1mr26RwSmInWQb3ntB2AFdeFPQ06R3Yp3gsCVJuHAqp3Phb5ELN0DwcZxP7rUa/
G20m/qLqRKc=
=zbxk
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--
