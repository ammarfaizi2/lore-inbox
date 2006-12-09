Return-Path: <linux-kernel-owner+w=401wt.eu-S966223AbWLIUjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966223AbWLIUjc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966246AbWLIUjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:39:32 -0500
Received: from alnrmhc12.comcast.net ([206.18.177.52]:51202 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966223AbWLIUjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:39:31 -0500
Message-ID: <457B1F02.7030409@comcast.net>
Date: Sat, 09 Dec 2006 15:39:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PAE/NX without performance drain?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Apparently (as I've been told today) using a hardware NX bit in a 32-bit
x86 kernel requires PAE mode.  PAE mode is enabled with HIGHMEM64, which
is (apparently) extremely slow.

Is it possible to give some other way to get the hardware NX bit working
in 32-bit mode, without the apparently massive performance penalty of
HIGHMEM64?


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXsfAAs1xW0HCTEFAQIb3xAAhuVgOGGff6N3BQFUjej6PozDDcc56C2P
pS+6JOdUaFWNfBbBg9FWbeGkW8thwNOfRRaTgE3TXar44djwd8rmjfFx9siWenue
sYbdn61LYWsTRsRuS3noD49Dn3vj/sOv8pPEiz6ZPYd3kgkuipQHNVWUUjR7mne/
9o5P4ajae4gcml7z3CcQVO8CkCFpCqQUPwXz2yVBPGEi4DEJHrNIlr8mbP2uBPkD
nXcMY5KmHovDyueihoaVInzBdIhNGUSFEc6mfZS0bluCLaNUudWJCZDjEwunHS7M
ngySKIQC2U3I0tgdok00Szum2NRlwclDNpoQP4x9577v/rCTVKfOxv+CioK+DXG2
QnYBPuicI31f2++itubnidLgCiBtjbuwHaz0OMMg9Ix7xws4WX2BLykuenRAxN9f
F+TZuJJq8sD1CfTveomZq7UP8mpBECXB+HRTMNdpIy+QJ19Eg8p4N/l2pep1hvDv
UA6tafSopIXEzcQKQ6Yi1MI8Du79O1zpTWzS+Hwgl+t3XfkI2e04wq7D4aN2ZMlw
b3S3h6Lp4I9EgqPLBnu+s2/AkRa/AxZc3eGbgf8Fz75sbDYvRnuhXzSxAmmJru5D
d51uB0GuHbiser+axWIj886pAOLPa2KGYpAjm7gtmVWFBNhzx5gnQRJkrxIcg4ew
JOb4VR4yfB8=
=QCVY
-----END PGP SIGNATURE-----
