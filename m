Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUAMVIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUAMVIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:08:42 -0500
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:2968 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S265617AbUAMVIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:08:36 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Eric Blade <eblade@blackmagik.dynup.net>
Subject: Re: dmesg gives me request_module fail 2.6.1
Keywords: net-pf-10
References: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: So Lonely --- [The Police]
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, Eric
 Blade <eblade@blackmagik.dynup.net>
Date: Wed, 14 Jan 2004 07:08:25 +1000
In-Reply-To: <20040113112123.21902bbf.eblade@blackmagik.dynup.net> (Eric
 Blade's message of "Tue, 13 Jan 2004 11:21:23 -0500")
Message-ID: <microsoft-free.87fzejpnee.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Eric Blade <eblade@blackmagik.dynup.net> writes:

  > request_module: failed /sbin/modprobe -- net-pf-10. error = 65280

net-pf-10 is IPv6, if you don't have that in your kernel, add the
following to your `/etc/modprobe.conf'...

  install net-pf-10 /bin/true

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkAEXk0ACgkQHSfbS6lLMAODvgCglXXyF6WA8mmk91S3xHmDVgj+
KhAAmQEfB/s/louZ/yOl8eRvcuClMSaa
=bbqC
-----END PGP SIGNATURE-----
--=-=-=--
