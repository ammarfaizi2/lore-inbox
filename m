Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265221AbUEYUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUEYUek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUEYUek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:34:40 -0400
Received: from mout1.freenet.de ([194.97.50.132]:30146 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S265221AbUEYUec convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:34:32 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: root@chaos.analogic.com
Subject: Re: System clock running too fast
Date: Tue, 25 May 2004 22:34:28 +0200
User-Agent: KMail/1.6.2
References: <200405251939.47165.mbuesch@freenet.de> <1085514395.11860.8.camel@athlon> <Pine.LNX.4.53.0405251619520.954@chaos>
In-Reply-To: <Pine.LNX.4.53.0405251619520.954@chaos>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405252234.29905.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 25 May 2004 22:25, Richard B. Johnson wrote:
> Ahahh.. Did you accidentally set CONFIG_MELAN in .config? That would

mb@server:~/kernel> cat .config |grep MELAN
# CONFIG_MELAN is not set

> do about 1 second fast per hour. If not, then do: echo "">/etc/adjtime
> (used to be you could delete it), now I think you
> need to truncate it. Sometimes this file gets corrupt and
> it takes many settings of stime to undue the corrupt-ness.

Done. Let's see if it works.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAs63UFGK1OIvVOP4RAob7AKCdKfq0CZ4bO1bU2/4JVmz+qReX8ACfShMA
PkLDDsstNG6geWzQImh1ur0=
=bYEy
-----END PGP SIGNATURE-----
