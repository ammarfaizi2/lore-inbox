Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbRGRNRC>; Wed, 18 Jul 2001 09:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbRGRNQw>; Wed, 18 Jul 2001 09:16:52 -0400
Received: from dragonfire3.delta.com ([205.174.22.22]:1147 "EHLO
	satlmsghub03.delta-air.com") by vger.kernel.org with ESMTP
	id <S267873AbRGRNQd> convert rfc822-to-8bit; Wed, 18 Jul 2001 09:16:33 -0400
Message-ID: <BDEE1F50C0C6D411BBB600204840D7B40124F182@satlrccdmrus25.delta-air.com>
From: "Dominick, David" <David.Dominick@delta.com>
To: =?ISO-8859-1?Q?=27Christian_Borntr=E4ger=27?= 
	<christian@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: RE: sound?!?!!?
Date: Wed, 18 Jul 2001 09:16:30 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yup it is there...
Funny that the impossible things were easy to get configured, and the pnp bs
is impossible.
-----Original Message-----
From: Christian Bornträger [mailto:christian@borntraeger.net]
Sent: Wednesday, July 18, 2001 3:06 AM
To: Dominick, David; linux-kernel@vger.kernel.org
Subject: Re: sound?!?!!?


> when running sndconfig I get:
> /lib/modules/2.4.6/kernel/drivers/sound/sound.o: unresolved symbol
> request_module

Its only a guess, but have you included kmod in the Kernel?

cd /usr/src/linux
grep KMOD .config 
	should look like:

CONFIG_KMOD=y
