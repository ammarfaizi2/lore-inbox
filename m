Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131552AbQKJTKQ>; Fri, 10 Nov 2000 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131491AbQKJTKG>; Fri, 10 Nov 2000 14:10:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65293 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131552AbQKJTJ5>; Fri, 10 Nov 2000 14:09:57 -0500
Message-ID: <3A0C46DB.3C347221@timpanogas.org>
Date: Fri, 10 Nov 2000 12:04:59 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <200011101905.eAAJ5qi25826@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:
> 
> "Jeff V. Merkey" <jmerkey@timpanogas.org> SAID:
> > "William F. Maton" wrote:
> 
> [...]
> 
> > > What about sendmail 8.11.1?  Is the problem there too?
> 
> > Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> > encryption.
> 
> I've been using sendmail-8.11.1 (no encryption) to talk to MTAs all over
                                   ^^^^^^^^^^^^^^

Turn on encryption, and try sending attachements > 1MB and tell me if
you see any problems, like emails sitting in /var/spool/mqueue for a day
or two until they go out.  I can guarantee you will.

Jeff


> the place, many of them so old it is scary. No problems seen at this end.
> This is to be expected, BTW: They can't just go in and release an MTA which
> doesn't talk to the rest ot the world, now can they.
> --
> Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
