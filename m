Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWIDBHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWIDBHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 21:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWIDBHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 21:07:01 -0400
Received: from natblert.rzone.de ([81.169.145.181]:30374 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S932191AbWIDBHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 21:07:00 -0400
From: Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>
To: linux-kernel@vger.kernel.org
Subject: Building Comedi modules for 2.6.17
Date: Mon, 4 Sep 2006 03:06:34 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart22700790.1d3DECYTz5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609040306.41292.Wolfgang.Draxinger@campus.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart22700790.1d3DECYTz5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I know it's not the perfect place to ask for, but the Comedi project=20
seems to be quiet (dead?) for a lot of months, and I figured, that=20
eventually some people who did the job already can help me out.

Unfortunately I have to get a DAQ device working and the so=20
called "drivers" and "support" from the manufactor ****** me really=20
of; IMHO they're a case for gplviolations.org, since the drivers only=20
come for 3 certain distributions in the versions as they are sold in=20
the self boxes. The kernel module is precompiled, no not only a BLOB=20
but merely a precompiles .ko for the kernels that ship with the=20
distribution CDs. And the supported Distributions are old. Not from=20
the stone ages, but thinking of ancient rome kinda comes close to it.

At first I really liked GKH's "Instrumentation I/O", but seeing how=20
industry cares I don't know if it was really such a great idea.

Ah, were was I? Right: Building the Comedi kernel modules. Making the=20
lib was easy enough, but it seems, that Comedi bypasses the kbuild=20
system (if that is to support multiple kernel versions why not just=20
deliver separate Makefiles and then make -F ?).

Diging in the google archive I found the suggestion, just to turn the=20
Makefiles into kbuild ones. I had the same idea, but OTOH I'm=20
probably not the only one with the same need, so eventually someone=20
already got those Makefiles done. In that case I'd really apreciate,=20
to get those.

Sorry for the large "venting"-overhead, but you should see that e-mail=20
in my draft box I'd really like to send the guy who suggested=20
me: "reconfigure your kernel, to make the module work"; OTOH that=20
poor guy probably only looked up the company's knowlegde base, which=20
is probably maintained by a groom.

Happy coding

Wolfgang - *grrrr* (not against comedi, but the ignorant hardware=20
industry) - Draxinger
=2D-=20
E-Mail address works, Jabber: hexarith@jabber.org, ICQ: 134682867
GPG key FP: 2FC8 319E C7D7 1ADC 0408 65C6 05F5 A645 1FD3 BD3E

--nextPart22700790.1d3DECYTz5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE+3whBfWmRR/TvT4RAjpsAJ9BK4ivEJ5RRTS4eGd444CVCsH3zQCbBgKw
TKMb03TxGBB2ZIrAQ3Ud4eA=
=6Mxw
-----END PGP SIGNATURE-----

--nextPart22700790.1d3DECYTz5--

-- 
VGER BF report: U 0.900631
