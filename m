Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAaLsc>; Wed, 31 Jan 2001 06:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbRAaLsW>; Wed, 31 Jan 2001 06:48:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:42244 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130006AbRAaLsI>; Wed, 31 Jan 2001 06:48:08 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.64368.42003.532324@wire.cadcamlab.org>
Date: Wed, 31 Jan 2001 05:48:00 -0600 (CST)
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
In-Reply-To: <3A772D3C.CB62DD4F@megapath.net>
	<m14NsuB-000OZJC@amadeus.home.nl>
	<20010131045520.B32636@cadcamlab.org>
	<20010131120712.A11819@fenrus.demon.nl>
	<14967.62433.949844.559264@wire.cadcamlab.org>
	<20010131121952.A11947@fenrus.demon.nl>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Arjan van de Ven]
> That won't work, unless you also want to force the soundlayer on
> people.  Which is unacceptable. period.

I didn't say it was pretty, I said it was possible.
I, too, like your #ifndef solution better.

I suppose yet another hack would be to put a certain amount of #ifdef
and #include hackery into radio-miropcm20.c to suck in aci.c if
needed.  That would be even worse ... but possible.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
