Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUANB0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUANB0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:26:13 -0500
Received: from gizmo13ps.bigpond.com ([144.140.71.23]:61871 "HELO
	gizmo13ps.bigpond.com") by vger.kernel.org with SMTP
	id S265878AbUANB0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:26:11 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe failed: digest_null
Keywords: module
References: <20040113215355.GA3882@piper.madduck.net>
	<20040113143053.1c44b97d.rddunlap@osdl.org>
	<20040113223739.GA6268@piper.madduck.net>
	<20040113144141.1d695c3d.rddunlap@osdl.org>
	<20040113225047.GA6891@piper.madduck.net>
	<20040113150319.1e309dcb.rddunlap@osdl.org>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: I Don't Know You Anymore --- [Savage Garden]
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Wed, 14 Jan 2004 11:26:00 +1000
In-Reply-To: <20040113150319.1e309dcb.rddunlap@osdl.org> (Randy Dunlap's
 message of "Tue, 13 Jan 2004 15:03:19 -0800")
Message-ID: <microsoft-free.87isjffhhz.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Randy Dunlap <Randy.Dunlap> writes:

  > The message:
  > kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
  > is from modutils and not from module-init-tools according to my
  > source files.

Your correct about where this message _doesn't_ come from, but not
about where it _does_ come from...

,----[ ./kernel/kmod.c -- lines 113 - 115 ]
| printk(KERN_DEBUG
|        "request_module: failed %s -- %s. error = %d\n",
|        modprobe_path, module_name, ret);
`----


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

iEYEABECAAYFAkAEmqoACgkQHSfbS6lLMAM2sgCgojh9cXvEPXp4mTde4foW+FFU
hrwAoLEd16bwDCpdEhln6d3gywWms58r
=EFcJ
-----END PGP SIGNATURE-----
--=-=-=--
