Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTAPGYE>; Thu, 16 Jan 2003 01:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbTAPGYD>; Thu, 16 Jan 2003 01:24:03 -0500
Received: from h80ad2549.async.vt.edu ([128.173.37.73]:33921 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267039AbTAPGYC>; Thu, 16 Jan 2003 01:24:02 -0500
Message-Id: <200301160632.h0G6Wqte002864@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Dell C840, 2.5.58, NVidia - something is on serious crack...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-209237824P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Jan 2003 01:32:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-209237824P
Content-Type: text/plain; charset=us-ascii

OK, so I get brave enough to try the NVidia drivers (no snickers please -
they Just Work under 2.4.18, and do a better job of finding the monitor
attached to my docking station than the 'nv' drivers do).

I get the 4191 drivers, apply the 2 patches from www.minion.de, get it
insmod'ed, and fire up X.   Disks go chugga chugga for a bit, and then
I'm left looking at a black screen.  No disk activity.  Wedged.  Screwed.
So I decide to get something to drink from the refrigerator, and when I
get back, there's a tiny blue icon in the upper left corner:

 *******
*       *
* *   * * 
*       *
* *   * *
*  ***  *
*       *
 *******

Say *WHAT*?  Where did that come from?  Wait a bit more. Nothing else.
Power cycled (since nothing else is working), and try again.  System
starts booting up fine, and goes to start up XFree86. Sure enough,
same black screen, and about 2 minutes later, the icon pops up again.

Any idea where *THAT* came from?

For what it's worth, the last 3 or so lines of the XFree86.log are:

(**) NVIDIA(0): Use of AGP disabled per request
(--) NVIDIA(0): Linear framebuffer at 0xE0000000
(--) NVIDIA(0): MMIO registers at 0xFC000000

Nothing in the syslog, and it's possible there were further msgs that
didn't get flushed to disk - I haven't checked if XFree86 fsync()s the log.
The timestamp on the file matches when the screen went blank and things hung.

/Valdis

--==_Exmh_-209237824P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+JlIUcC3lWbTT17ARApTaAJ9cIO52XYoICZWFrktNd+9gFIqpFACfV7GR
hvuqGkFnm8dlB2MYhJqUzxo=
=vjTe
-----END PGP SIGNATURE-----

--==_Exmh_-209237824P--
