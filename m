Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132015AbQKJWcp>; Fri, 10 Nov 2000 17:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131856AbQKJWcf>; Fri, 10 Nov 2000 17:32:35 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:3875 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131842AbQKJWcZ>; Fri, 10 Nov 2000 17:32:25 -0500
Date: Sat, 11 Nov 2000 00:40:14 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, wmaton@ryouko.dgim.crc.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in
 /var/spool/mqueue] 
In-Reply-To: <200011101905.eAAJ5qi25826@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.21.0011110038220.6465-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> > encryption.
> 
> I've been using sendmail-8.11.1 (no encryption) to talk to MTAs all over
> the place, many of them so old it is scary. No problems seen at this end.
> This is to be expected, BTW: They can't just go in and release an MTA which
> doesn't talk to the rest ot the world, now can they.

The only things sendmails < 8.10.x all suffer from is the crappy mapper
code. This causes all kinds of weard problems (logging not complete,
undelivered mail), especially if an external problem mucks around with the
mapper files (those .db things for example).

I had no problems with 8.11.x not talking to qmail or any other MTA.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
