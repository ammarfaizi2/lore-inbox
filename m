Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278514AbRJaHx6>; Wed, 31 Oct 2001 02:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280080AbRJaHxt>; Wed, 31 Oct 2001 02:53:49 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:60421 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S278514AbRJaHxf>;
	Wed, 31 Oct 2001 02:53:35 -0500
Message-Id: <5.1.0.14.0.20011031184004.02302d70@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Oct 2001 18:54:07 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS sound driver
Cc: alan@lxorguk.ukuu.org.uk
In-Reply-To: <E15yV7z-0005sP-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.0.20011030133431.00a70b90@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:24 AM 30/10/01 +0000, Alan Cox wrote:
> >   PCI: Sharing IRQ 5 with 00:0c.1
> >   trident: SiS 7018 PCI Audio found at IO 0x1000, IRQ 5
> >   ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
>
>It's failing to initialise the AC97 codec. That may be timing (try longer
>delays for one). Also try load, unload, load sequences. It may be the ac97
>is wired strangely on your box.

Tried load/unload/load sequences with no luck. Tried increasing all the 
relevant delays within the ac97 and trident drivers, and while I think I've 
found a bug in a small part of the ac97 driver (trivial, will post soon, 
but isn't causing my problem), still no luck (even with load/unload/load 
again). Any suggestions on where I should try delays in the code?

If this is a weird ac97 implementation, any suggestions on how I'd go about 
figuring it out? Possible diagnosis utils and the like are always a boon, 
even if I have to run Windows on the thing and figure out how it's doing 
it. Since I have 2 of these machines, I can always run them in parallel and 
compare stuff between.

Many thanks.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

