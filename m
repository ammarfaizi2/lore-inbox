Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbRAaBtd>; Tue, 30 Jan 2001 20:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRAaBtY>; Tue, 30 Jan 2001 20:49:24 -0500
Received: from quechua.inka.de ([212.227.14.2]:10342 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131230AbRAaBtQ>;
	Tue, 30 Jan 2001 20:49:16 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-Id: <E14NmOc-0001Tc-00@sites.inka.de>
Date: Wed, 31 Jan 2001 02:49:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010131133123.A7875@metastasis.f00f.org> you wrote:
> On Tue, Jan 30, 2001 at 02:17:57PM -0800, David S. Miller wrote:

>     8.5MB/sec sounds like half-duplex 100baseT.

> No; I'm 100% its  FD; HD gives 40k/sec TCP because of collisions and
> such like.

>     Positive you are running at full duplex all the way to the
>     netapp, and if so how many switches sit between you and this
>     netapp?

> It's FD all the way (we hardwire everything to 100-FD and never trust
> auto-negotiate); I see no errors or such like anywhere.

> There are ... <pause> ... 3 switches between four switches in
> between, mostly linked via GE. I'm not sure if latency might be an
> issue here, is it was critical I can imagine 10 km of glass might be
> a problem but it's not _that_ far...

>   --cw

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



> -------------------------------------------------------------------------------
>    Achtung: diese Newsgruppe ist eine unidirektional gegatete Mailingliste.
>      Antworten nur per Mail an die im Reply-To-Header angegebene Adresse.
>                    Fragen zum Gateway -> newsmaster@inka.de.
> -------------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
