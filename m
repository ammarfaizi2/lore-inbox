Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289094AbSAJAUT>; Wed, 9 Jan 2002 19:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSAJAUA>; Wed, 9 Jan 2002 19:20:00 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:28862 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S289094AbSAJATm>; Wed, 9 Jan 2002 19:19:42 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Martin Josefsson'" <gandalf@wlug.westbo.se>,
        "'Ville Herva'" <vherva@niksula.hut.fi>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        "'Jani Forssell'" <jani.forssell@viasys.com>
Subject: RE: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Date: Thu, 10 Jan 2002 00:19:38 -0000
Message-ID: <001401c1996c$7d8dd790$0100a8c0@icarus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I havn't followed this thread but I have a machine with an
> Asus A7V motherboard with KT133 chipset and we had massive 
> corruption before christmas, both ide and network had 
> corrupted packets. and now after christmas we ran memtest86 
> on it and a 256MB module was very very broken. and we got 
> alot of Oopses and all kinds of strange stuff happened.
> 
> We've replaved that memory module now and now it's better but
> I have to say that the KT133 or atleast the Asus A7V 
> motherboard seems to be quite broken. we have a lot of 
> spurious irq's and the ide controllers freak when but under 
> some load and start getting irq timeouts and resets the ide 
> channels over and over again with some delay in between when 
> it kind of works, slow as hell but works.

There are known issues with the VIA 82C686A/B chipset south-bridge and
IDE in particular. Make sure you have the latest BIOS and latest VIA
4in1 drivers to workaround the IDE corruption and other known issues
(sound problems with certain soundcards).

Dan
___________________
Daniel J Blueman

