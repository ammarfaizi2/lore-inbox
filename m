Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284009AbRLOWWX>; Sat, 15 Dec 2001 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLOWWO>; Sat, 15 Dec 2001 17:22:14 -0500
Received: from modemcable192.234-203-24.hull.mc.videotron.ca ([24.203.234.192]:5380
	"EHLO Krystal") by vger.kernel.org with ESMTP id <S284009AbRLOWWF>;
	Sat, 15 Dec 2001 17:22:05 -0500
Date: Sat, 15 Dec 2001 17:22:03 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Old i586 B stepping CPUs in SMP
Message-ID: <20011215172203.A915@Krystal>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-1110-1008454923-0001-2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.2.20 (i586)
X-Uptime: 17:08:01 up 15 min,  1 user,  load average: 0.03, 0.06, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-1110-1008454923-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I went through a problem on an old computer, which has 2 Intel Pentium
90mhz CPU (B stepping). The computer model is an AST Manhattan P5090. I
use a 2.2.20 kernel.

First of all, the SMP module from the kernel gives me this warning :
WARNING: SMP operation may be unreliable with B stepping processors.

I think I may have found the cause of what has been my problem (and
maybe the original cause of this warning).

Linux doesn't boot at all when IRQ 2/9 is used. I tried many
different configurations, disabling a lot of cards, and it seems to be
the cause of the problem. I believe that this information could be
useful in some SMP documentation, that's why I posted it.

Thanks to all for your excellent work! I hope that this little piece of
(obsolete?) information will help.

Mathieu Desnoyers

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-1110-1008454923-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G80LPyWo/juummgRAlLuAKCmDR8+WJZtqJ9ALbfopBaRKLezLgCcC/vb
9YkdCpnHoLBkOAh1yKOsz1M=
=0ZDe
-----END PGP SIGNATURE-----

--=_Krystal-1110-1008454923-0001-2--
