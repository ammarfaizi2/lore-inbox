Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSA0Ssb>; Sun, 27 Jan 2002 13:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSA0SsV>; Sun, 27 Jan 2002 13:48:21 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:32012
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S287373AbSA0SsN>; Sun, 27 Jan 2002 13:48:13 -0500
Message-Id: <5.1.0.14.2.20020127133725.00b0d470@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 27 Jan 2002 13:43:11 -0500
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
From: Stevie O <stevie@qrpff.net>
Subject: Re: 2.2.20: pci-scan+natsemi & Device or resource busy
  [Success!]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020127095000.GA11142@elektroni.ee.tut.fi>
In-Reply-To: <5.1.0.14.2.20020126183314.01cbb510@whisper.qrpff.net>
 <5.1.0.14.2.20020126183314.01cbb510@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I don't know wtf was wrong, but a few lspci's revealed that whoever's in 
charge of enumerating wasn't even seeing the cards at all... To test, I had 
him put three more cards in -- a winmodem, a soundcard, and an older 
netgear card -- and he placed them like this:
[FA-311] [Winmodumb] [FA-311] [Soundcard] [Empty] [Old Netgear]
and lspci showed this:
<empty slot>
<winmodumb>
<empty slot>
<soundcard>
<empty slot>
<old netgear>

After fiddling with it some more the machine magically started to see the 
cards again, at which point everything worked fine. Weird.

TY to all who helped!


--
Stevie-O

Real programmers use cat > /vmlinuz

