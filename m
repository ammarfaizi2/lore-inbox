Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbRE3LsF>; Wed, 30 May 2001 07:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbRE3Lrz>; Wed, 30 May 2001 07:47:55 -0400
Received: from ns.caldera.de ([212.34.180.1]:4328 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262741AbRE3Lrg>;
	Wed, 30 May 2001 07:47:36 -0400
Date: Wed, 30 May 2001 13:47:29 +0200
Message-Id: <200105301147.f4UBlTA32401@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: Marcus.Meissner@caldera.de (Marcus Meissner)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 3c509 PNP80f7 id
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010530130905.A29368@caldera.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010530130905.A29368@caldera.de> you wrote:
> Hi,
>
> This adds the PNP80f7 compat Id to 3c509.c, making it now autodetect my 
> '3C509B EtherLink III'.
>
> BTW, there is a problem there:
>
> It has a card id of TCM5094 and a function id of PNP80f7, the cardid is
> already there, but only probed as function id...
>
> Anyway, I will let the dust settle on the ISAPNP module issue first before
> fixing it ;)

An option might be to use the proper isapnp_probe_devs() function instead
of hand-coded probing code...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
