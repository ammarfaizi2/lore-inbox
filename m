Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSJMDfF>; Sat, 12 Oct 2002 23:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSJMDfF>; Sat, 12 Oct 2002 23:35:05 -0400
Received: from [218.245.208.194] ([218.245.208.194]:16000 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261417AbSJMDfE>;
	Sat, 12 Oct 2002 23:35:04 -0400
Date: Sun, 13 Oct 2002 11:33:29 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch for 2.5.42. 2/2
Message-Id: <20021013113329.5171e784.hugang@soulinfo.com>
In-Reply-To: <Pine.LNX.4.44L.0210130133070.22735-100000@imladris.surriel.com>
References: <20021013112019.496010fc.hugang@soulinfo.com>
	<Pine.LNX.4.44L.0210130133070.22735-100000@imladris.surriel.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.wyXVXaQFUdWVlN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.wyXVXaQFUdWVlN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2002 01:34:22 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

|On Sun, 13 Oct 2002, Hu Gang wrote:
|
|> --- linux-2.5.42/drivers/net/3c59x.c	Sat Oct 12 21:25:00 2002
|> +++ linux-2.5.42-suspend/drivers/net/3c59x.c	Sat Oct 12 21:20:48 2002
|
|> +#ifdef CONFIG_PM
|> +	int in_suspend;
|> +#endif
|
|This looks like a serious design mistake.  Surely it would be
|better to just have the network layer stop operations when the
|system is going into suspend, instead of having to modify 100
|individual network drivers ?

Yes, The other drivers have this problem , such as sound.

I'm can not confirm that idea is the best way. But I can not found any other way can do it. If you have good idea, Tell me know.

thanks.
-- 
		- Hu Gang

--=.wyXVXaQFUdWVlN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qOmJPM4uCy7bAJgRAlwCAJ95uIRhb2jBHnhfsSRdglsCbwacKgCfTyBw
s3nRMVVCDDsFdXdcd1B9csc=
=GkGm
-----END PGP SIGNATURE-----

--=.wyXVXaQFUdWVlN--
