Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbRFKQzy>; Mon, 11 Jun 2001 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbRFKQzo>; Mon, 11 Jun 2001 12:55:44 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:35319 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S262400AbRFKQzh>;
	Mon, 11 Jun 2001 12:55:37 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [CHECKER] 15 probable security holes in 2.4.5-ac8
Date: Mon, 11 Jun 2001 12:54:51 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGEEDBCJAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E159Udo-0008RP-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > What someone *really* needs to do is design a Z8530 adapter with a USB
> > interface.  The amateur radio community (well, the 56K'ers, at
> any rate),
> > would love such a device.  The PI2 card is a flakey beast, at best.
>
> You would be much better off attaching a straight ADC/DAC at say up to
> 256Kbits/8bit sampling and some control lines to the USB. That would also
> let people dumb the ridiculous 1960's technology they insist on using and
> run serious stuff like adaptive encoders, golay codecs and the like and
> bring amateur packet radio out of the stone age
>
> Alan
>

Ideally, yes.  However, client side DSP at these kinds of data rates still
isn't practical.  Most people are lucky if they can get 9600 baud, although
admittedly some of that is a function of trying to use a standard sound card
with it's limited input bandwidth (apx 22Khz).

It also doesn't solve the bigger problem, which is existing 56K users that
want to upgrade machines, but can't, because the PI2 card flakes out in
almost all systems that have PCI.  The card has some timing issues to start
with, and are aggrevated by how almost all PCI chipsets implement the ISA
bus side.

I don't currently have my 56K station up, but I keep an old ISA only
486DX/80 system around just so I can use the card once I get in a position
to (living on a houseboat creates some space problems for both machines, and
antennas).

I don't know if you're familiar with the Heatherington 56K design or not,
but there's some information at his website, www.wa4dsy.org.  Dale, for
those that don't know, was one of the 2 (or 3, depending on how you count)
founders of Hayes Microcomputer (D.C. Hayes, at the time), and did the
SB-103 and Smartmodem-300 designs, plus many other designs.

-- John

