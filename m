Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTIOF5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTIOF5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:57:20 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:38311 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262446AbTIOF5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:57:19 -0400
Date: Mon, 15 Sep 2003 08:57:00 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Marcelo Penna Guerra <eu@marcelopenna.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
In-Reply-To: <200309112357.41592.eu@marcelopenna.org>
Message-ID: <Pine.LNX.4.56.0309150855530.10273@hosting.rdsbv.ro>
References: <200309112357.41592.eu@marcelopenna.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In recent kernels, the siimage driver limits the max kb per request size to 15
> (7.5kb). As I was having no problems with rqsize of 128 (64kb), I decided to
> comment out this part of the code and my system is rock solid.
>
> I'm not suggesting that it should be removed, as it probably is necessary on
> other systems, but as the performance impact is huge (with 15 hdparm tests
> show an average 26mb/s and with 128 it's 47mb/s), I think the user should be
> warnned of this and there could be a option to set it to 128 in 2.6.x
> kernels, so people can try to see if it's stable. I really don't beleive that
> I have such an unique hardware configuration, so this should benefit other
> people.

I'm using 256 or 128, I don't remember exactly with a sii3112. It is rock
solid.

>
> Marcelo Penna Guerra
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
>
> iD8DBQE/YTYjD/U0kdg4PFoRAhBnAJ0TyeJx5nrxzDS5Rib5AEWQHx4iSACeKcn8
> wg7cUhLobywfTCcPl8GqNCc=
> =VuVw
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
