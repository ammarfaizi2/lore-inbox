Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTEZCXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTEZCXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:23:50 -0400
Received: from h80ad2789.async.vt.edu ([128.173.39.137]:4992 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263859AbTEZCXt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:23:49 -0400
Message-Id: <200305260236.h4Q2ala7003115@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mikpe@csd.uu.se
Cc: lkml@sigkill.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: Your message of "Sun, 25 May 2003 12:50:28 +0200."
             <200305251050.h4PAoSoG028882@harpo.it.uu.se> 
From: Valdis.Kletnieks@vt.edu
References: <200305251050.h4PAoSoG028882@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_634221070P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 May 2003 22:36:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_634221070P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 May 2003 12:50:28 +0200, mikpe@csd.uu.se said:

> The blacklist rule is a catch-all since we don't have detailed DMI
> data on all Inspiron/Latitude models, and at the time, _all_ of them
> were broken. Looking through my records, Inspiron 8000 and 8100, and
> Latitude C600, C610, C640, C800, and C810 are known to be broken. Note
> that this includes at least one P4-based machine (C640), so it's not
> restricted to "old" mobile P3s.

OK, I put together a kernel that had the Latitude blacklist commented out,
and it comes up with:

No local APIC present or hardware disabled
Initializing CPU#0

So add the Latitude C840 to the "known b0rken" list.

--==_Exmh_634221070P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE+0X2+cC3lWbTT17ARAn7DAJiuZhNNmD8a0KGws0jfHG3Z4LC+AKCC2Lzo
hN1PPgxAm83vw5/qLyDKkw==
=TLu9
-----END PGP SIGNATURE-----

--==_Exmh_634221070P--
