Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIGFgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIGFgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUIGFgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:36:39 -0400
Received: from ns1.kisikew.org ([66.11.160.83]:4993 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S267509AbUIGFgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:36:37 -0400
Date: Tue, 7 Sep 2004 05:36:35 +0000
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Cc: simon@nuit.ca
Subject: oops sig11 with mingetty, vts in 2.6.8.1
Message-ID: <20040907053634.GB10437@nuit.ca>
Reply-To: simon@nuit.ca
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040818i
X-Scan-Signature: smtp.nuit.ca 1C4Yeh-00042U-F9 5e67897277336169ec2cc42820799aab
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



oops:

Oops kernel access of sig11
	NIP: C017651C LR: C01706C4 SP: C344FE20 REGS: c344fd70 TRAP: 0300
	MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
	DAR 00000000 DSISR 40000000=20
	syscall 54
	Thread c344e000
	NIP [c017651c] vt_ioctl+0x28/0x1c48
	LR [c01706(something)] tty_ioctl 0x15c/0x5b8

then calltrace about mingetty *checks logs* (nothing in logs :( )

now mingetty behaves, but about half an hour ago i had just "upgraded"
my installation's xfree packages (debian sid) i was switching windows in
screen, and as soon as a i had switched from irssi to mutt, the uxterm
the screen session was running in crashed. did the same with mc, too.=20

kernel version involved is 2.6.8.1


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQT1I4WqIeuJxHfCXAQKRhAv9Ep0fsN0TGhzpwWC7ZbRaOXFFqjJ9OYJt
kmn9HQBohBRzGPGkeqM+dW8h8zCKTYrVXwZ1lx16Q8muMOecOxqupvdtedXHmE6y
Qv+SrcodxawjbOdDkWfTEC/6h00ZyTdk//OCwvarSjzaRK19cDAEASecU5Groh/q
IGTmWAUDrQdhDt+QpDGWxiklAhHEvoNPIjQc7/Rzq5NesI42KHPCPbCBcFMHipKl
2uHTf4JyQetxmPGN4mA46yqGpWkDDXENBaAM/wFL85qdptciJnUtDkVCjt8mRmpA
edbqMK8y2LdYR0/D/c08q5uWf6VHOsP5lMTo9djdoB2X+1p78sY6EOpXKwmlZ7tM
bOJlT0y7BMGApgsfGzW1/M7LANf9GAJBj+VJuFm+P9HTht+sRLBtbtRe5J4M3VC3
fNvBAqdkXoI5hw/V0F37WjpG/NYDAidzreTs6Se65vDvukRubn2jsr0s+SPG5E8K
7qKvWPfYjjwVsq1vEwUKy/dWn36TVEd4
=2jGD
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
