Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUBACVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 21:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbUBACVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 21:21:21 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.15]:27265 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S265181AbUBACVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 21:21:20 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: net-pf-10, 2.6.1
References: <E1AmU8a-00005E-00@localhost>
	<Pine.LNX.4.44.0401301532260.9270-100000@gaia.cela.pl>
	<20040131233551.GA660@toraigh>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: Love Me Do --- [The Beatles]
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Sun, 01 Feb 2004 12:21:12 +1000
In-Reply-To: <20040131233551.GA660@toraigh> (Jim McCloskey's message of
 "Sat, 31 Jan 2004 15:35:51 -0800")
Message-ID: <microsoft-free.87k737r147.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Jim McCloskey <mcclosk@ucsc.edu> writes:

  >   |>  >    install net-pf-10 /bin/true          

This _is_ what you want in your modprobe.conf file.  Or possibly
`install net-pf-10-* /bin/true', but I'm pretty sure that Rusty has
added some backward compatibility code so that either _should_ work.

The other thing that you need to do once you have updated
modprobe.conf is to run `depmod' to regenerate the dependency files.

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

iEYEABECAAYFAkAcYpoACgkQHSfbS6lLMAN/agCfaNOtl8HhnFSpQzu1O60kKOo7
5i0AoIO4GFzIFjZCWHpuNchBPEHvxlLi
=3qpj
-----END PGP SIGNATURE-----
--=-=-=--
