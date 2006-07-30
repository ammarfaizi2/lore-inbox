Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWG3Lf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWG3Lf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWG3Lf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:35:29 -0400
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:36785 "EHLO
	smtp2.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S932277AbWG3Lf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:35:28 -0400
Date: Sun, 30 Jul 2006 13:35:26 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc2-mm1 fails to reboot properly on Dell Latitude CPiA
Message-ID: <20060730113526.GA5336@hermes.uziel.local>
References: <20060727015639.9c89db57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

After rebooting "normally" through init 6, or by hitting sysrq-b, the
backlight won't come back on and BIOS seems to hang at POST or
something.  After a power cycle, it runs the extensive POST instead of
the quick one. Same goes for -rc1-mm2, btw. kexec runs fine, as long as
I provide the "implicit" initramfs file required by the newer -mm
releases at load time.

Any recent changes related to the way i386 machines are kicked to
reboot?

In case anyone needs any info, I'll provide that asap, but right now I
don't have a clue at all. Afraid I cannot test on my workstation, since
my screen died and I don't have a replacement/cannot afford a purchase
right now.


TIA,
Chris

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUBRMyZfanY3eLOiwZcAQruNRAAnVL4nevnQFQgTtL4KACI3jIqQ9u9sZHO
D0ftD2h4+bY6ZXjVv8/eYA8md4cQ/q0OwsPLHhEQyveFVT5jD08gf/1alyi3knqx
3oLqCnQc5AKTELKsKSokBIGj2tTpeTVxjS8q7JZMPXnA3vYNYY9FdWJK8LOSvCbb
7Z5wdzfqivQew+KNj0bZnHLtzqFk+ijMLCGMEyfiARWius7vdHKRL7Qk60qyy+zf
HEtwft5y3VAR8H1QomZXzgEqdAT1wH23VbEEkNBtSCIgDdg6zwjGDEjWaQfUwlHN
XVitFQt93VsoRxckTYjx+x1AVcwbTYe5lBINEWvDPTsP2mKZmdovznIRrVsW2/+g
RjVVS3w7PKj0UPxF5JwANMhjX+Ly2UsemDrdmzSNzm2S0Bg5OclkhihrK/gcV+Py
QooxORZ6kTNsqNYAqIr+ADSdPdtBqwBV45a3KwYMMqNr53sPyfC2zyOy7tnkF+dn
d+bBUf1x1n0Ya9Os745gDM1GsneMcki42cWgTUuq2xcL3isr3nH7fHyZJ+XTnRpj
CfyD1JKFbRl+1UHx/8IxUOSh333QjbDJq9pluyLdQmGOoMTkj0OK7GEgeAxWEd7I
VTNqD9YntYbi6ABhjrHZEiujiZUOAzjzzpFtdRL+AiUOy7IZF6PZ730JXtlz+keO
wyvngRdYrQ4=
=1iPX
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

