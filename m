Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbRGQULg>; Tue, 17 Jul 2001 16:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267002AbRGQUL0>; Tue, 17 Jul 2001 16:11:26 -0400
Received: from dragonfire3.delta.com ([205.174.22.22]:36707 "EHLO
	satlmsghub03.delta-air.com") by vger.kernel.org with ESMTP
	id <S267001AbRGQULO> convert rfc822-to-8bit; Tue, 17 Jul 2001 16:11:14 -0400
Message-ID: <BDEE1F50C0C6D411BBB600204840D7B40124F17E@satlrccdmrus25.delta-air.com>
From: "Dominick, David" <David.Dominick@delta.com>
To: =?ISO-8859-1?Q?=27Christian_Borntr=E4ger=27?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: RE: sound?!?!!?
Date: Tue, 17 Jul 2001 16:11:11 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, but yeah I tried both of those. I am trying to change the memory
addresses for the card itself in the bios now.

-----Original Message-----
From: Christian Bornträger [mailto:linux-kernel@borntraeger.net]
Sent: Tuesday, July 17, 2001 4:09 PM
To: Dominick, David; linux-kernel@vger.kernel.org
Subject: Re: sound?!?!!?


> it is most likely a problem with me, but I have tried everything and I
keep
> getting the error that device not found or busy. I get this rather I use

Possibly you already tried this, then ignore my ideas:

First idea:
It might be a stupid idea, as I don´t know your Toshiba but try to change
the 
PnP OS option in the BIOS. (from yes to no or from no to yes)
If you don´t have success set it back, of course.

Second idea:
Have you activated ISA PnP in the Kernel?
/proc/isapnp must exist and the sound module should be loaded after the 
isaPnP support. 
If /proc/isapnp exists, what is sndconfig doing?

Good Luck.
