Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUB2ScT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUB2Sbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:31:47 -0500
Received: from theshire.demon.nl ([82.161.26.30]:37677 "EHLO
	hal.shire.sytes.net") by vger.kernel.org with ESMTP id S262095AbUB2Sbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:31:45 -0500
Date: Sun, 29 Feb 2004 19:31:43 +0100
From: Robbert Haarman <lkml@inglorion.net>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 Build System and Binary Modules
Message-ID: <20040229183143.GA8057@shire.sytes.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
X-PGP-Key: http://www.inglorion.net/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list,

Excuse me for not finding this if it has been asked before. Please Cc any answers, as I am not subscribed to this list.

I am trying to port a driver for the Realtek 8180 wireless ehternet controller from 2.4 to 2.6. The module comes as a binary-only object file with some sources that can be adapted to fit the specific kernel. My problem is that I can't figure out how to get the 2.6 kernel to include the binary part (it's in a .o file). The new build system does a little too much magic - compiling the module from source to .ko without giving me a chance to sneak in the binary code. How do I get it to link in the .o file, without making it look for the like-named .c file?

Cheers,

Robbert Haarman

---
"UNIX was not designed to stop you from doing stupid things, because that
would also stop you from doing clever things."
	--Doug Gwyn

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAQjAPDgDISEp7l6ERAouFAJ0fM2XLZdyL6mv1KIalRP11hcHY1wCgnGuJ
UPWZsj4q6VMi7qwbArMM9GI=
=I4K9
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
