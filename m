Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTGCOX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTGCOX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:23:28 -0400
Received: from niobium.golden.net ([199.166.210.90]:39399 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S263394AbTGCOX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:23:26 -0400
Date: Thu, 3 Jul 2003 10:37:48 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 868] New: Files missing?
Message-ID: <20030703143747.GD17942@linux-sh.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <45000000.1057241473@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <45000000.1057241473@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2003 at 07:11:13AM -0700, Martin J. Bligh wrote:
> Error message: CC [M]  drivers/video/pm2fb.o
> drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory
> drivers/video/pm2fb.c:45:30: video/fbcon-cfb8.h: No such file or directory
> drivers/video/pm2fb.c:46:31: video/fbcon-cfb16.h: No such file or directo=
ry
> drivers/video/pm2fb.c:47:31: video/fbcon-cfb24.h: No such file or directo=
ry
> drivers/video/pm2fb.c:48:31: video/fbcon-cfb32.h: No such file or directo=
ry
> drivers/video/pm2fb.c:163: error: user_mode causes a section type conflict
> drivers/video/pm2fb.c:258: error: field `gen' has incomplete type
> drivers/video/pm2fb.c:287: error: field `disp' has incomplete type
> drivers/video/pm2fb.c:403: error: variable `pm2fb_hwswitch' has initializ=
er but=20
> incomplete type

These files are gone for a good reason. This driver simply needs to be upda=
ted
to the new API.


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/BD+71K+teJFxZ9wRApmZAJ9sSz4h7VT6W0191rwOCiFv0Bc17ACfXuPK
KgL+0//N8FB5CyxfoSI/sb8=
=Xg09
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
