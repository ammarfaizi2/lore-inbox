Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJKR24>; Thu, 11 Oct 2001 13:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276594AbRJKR2q>; Thu, 11 Oct 2001 13:28:46 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:26116 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S276369AbRJKR2l>; Thu, 11 Oct 2001 13:28:41 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "'John Gluck'" <jgluckca@home.com>
Subject: RE: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Thu, 11 Oct 2001 19:29:20 +0200
Message-ID: <002701c1527a$42bec1d0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <E15rjR4-000400-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume that should print out a message at bootup? That didn't happen:

Oct  7 18:29:18 radium eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Oct  7 18:29:18 radium eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified
by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Oct  7 18:29:18 radium eth0: OEM i82557/i82558 10/100 Ethernet,
00:D0:B7:E8:A2:02, IRQ 17.
Oct  7 18:29:18 radium Board assembly 749658-005, Physical connectors
present: RJ45
Oct  7 18:29:18 radium Primary interface chip i82555 PHY #1.
Oct  7 18:29:18 radium General self-test: passed.
Oct  7 18:29:18 radium Serial sub-system self-test: passed.
Oct  7 18:29:18 radium Internal registers self-test: passed.
Oct  7 18:29:18 radium ROM checksum self-test: passed (0xdbd8681d).

- Robbert

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: donderdag 11 oktober 2001 19:16
> To: Robbert Kouprie
> Cc: 'John Gluck'; linux-kernel@vger.kernel.org
> Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 
> 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
> 
> 
> > files. It would always lockup after said amount of traffic, 
> but only in
> > 10 Mbit half duplex mode. Also, I have the 82557, not the 
> 82558 chip.
> > 
> > The problem looks a lot like what should be fixed in this 
> changelog line
> > from 2.4.9-ac13:
> 
> Check the workaround is being activated for your eepro100..
> 

