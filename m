Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbTITOZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTITOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 10:25:41 -0400
Received: from NeverAgain.DE ([217.69.76.1]:36565 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261894AbTITOZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 10:25:39 -0400
Date: Sat, 20 Sep 2003 16:25:24 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: [PM] Further suspend/resume problems on Acer TravelMate 800
Message-ID: <20030920142524.GA2605@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

this morning, I tried to get ACPI suspend-to-ram work on my Acer=20
TravelMate 800 notebook. I did not use plain 2.6.0-test5 for that
but 2.6.0-test5-bk6 with (hopefully) all PM updates from latest
-mm patch for 2.6.0-test5 as well as latest ACPI updates from the
ACPI4Linux website. I even integrated a clean DSDT table.

The problem is: If I do 'echo 3 > /proc/acpi/sleep', the notebook
suspends but after pressing a button, it does not wake up really:
The cooler starts, then stops after some seconds but the screen
stays black. However, while typing blind, I can login to the box
and even ctrl+alt+del can be used to reboot the machine.

I had a look at syslog, it does not tell something about problems.
The last line related to PM is "Restarting tasks ... done". SMP,
Preempt and APIC are all disabled. So, soembody can give a hint
(or a patch?;) that would get rid of this last little problem (
at least at from what I can see at the moment)?

Thanks in advance,

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bGNUHPo+jNcUXjARAqSYAJ0T3OxRFZawRcW5zHfjA9yLXrkFmwCfVGDv
Pm0pf3vajUx/kKNlYg99VhE=
=8VD5
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
