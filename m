Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129653AbRBBOIe>; Fri, 2 Feb 2001 09:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129648AbRBBOIY>; Fri, 2 Feb 2001 09:08:24 -0500
Received: from www.topmail.de ([212.255.16.226]:2804 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129212AbRBBOII> convert rfc822-to-8bit;
	Fri, 2 Feb 2001 09:08:08 -0500
Message-ID: <02b101c08d21$923c5ac0$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>
In-Reply-To: <6lah7t4f685qo3igk679ocdo2obfhd9lvg@4ax.com> <20010201193255.A32191@thune.yy.com> <20010202115712.A31607@netppl.fi>
Subject: Re: spelling of disc (disk) in /devfs
Date: Fri, 2 Feb 2001 14:07:12 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh you English people,

why do you do it so complicated?
We even don't need a kernel locale.

Take the nominations as they are, color/colour,
disk/disc/diskette/floppy, etc.

And if you write by yourself, do it as you spell it.
I'd even write it German if I wasn't used to speak
fully English whilst coding.

And dont bother about names:
 - Namen sind Schall und Rauch. Was zaehlt, ist das, was drin ist.
(for tho who can understand it. the others: sorry, it's a cite.)

Does it _actually_ make a prob to use disc in devfs instead
of the (correct) disk when changing it broke configuration?
We are _not_ M$, we (usually) _dont_ break old systems.
And __colour does only matter when you directly access it.

Really, it's inconsistent, but it happened - so...
You could consider changing it on a two-year solution:
create a hardlink /dev/disks <-> /dev/discs in the KERNEL(!!)
and remove /dev/discs in two years.
Meanwhile everyone reading docu will have upgraded ;-)
(ref. to the 4-week pause before ECN on vger.kernel.org)

-mirabilos

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12+(proprietary extensions) # Updated:20010129 nick=mirabilos
GO/S d@ s--: a--- C++ UL++++ P--- L++$(-^lang) E----(joe) W+(++) loc=.de
N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv(silly)
b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM;GW-BASIC;C */
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
