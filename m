Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRL4S>; Mon, 18 Dec 2000 06:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLRL4I>; Mon, 18 Dec 2000 06:56:08 -0500
Received: from 1Cust136.tnt5.rtm1.nl.uu.net ([213.116.104.136]:32640 "EHLO
	ida.2y.net") by vger.kernel.org with ESMTP id <S129260AbQLRLzz>;
	Mon, 18 Dec 2000 06:55:55 -0500
Message-ID: <3A3DF406.8C3439C4@freeler.nl>
Date: Mon, 18 Dec 2000 12:24:54 +0100
From: Jorg de Jong <j.e.s.de.jong@freeler.nl>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, nl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: test12: innd bug came back?
In-Reply-To: <Pine.GSO.4.21.0012171623240.20573-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 17 Dec 2000, Jorg de Jong wrote:
> 
> > > >On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
> > > >
> > > >> Just to add a "me too" on this. I didn't report when I saw it last week,
> >
> > I'd like to second that. ME TOO !
> > Since I switched to 2.4.0.test12 I again have the innd bug.
> > ( well at least the same symptoms !)
> 
> I.e. old contents resurfacing in active?

I tryed your test program and got correct results, a file with bytes 11-16385 being zero.

I will try to give a description of my problems:
after a reboot inn is 're-using' existing messages to store new
messages. It seems that after a renumber command the active file 
is correced again. I have not checked to see if the active file
was corrutped before. 
I am using a plain stock kernel, no other patches what so ever,
but am using LVM. 

The blocksize the ext2 filesystem is using is 1024.

-- 
Jorg de Jong
Work : mailto:jorg.de.jong@ict.nl 
Play : mailto:j.e.s.de.jong@freeler.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
