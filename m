Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRAXPy5>; Wed, 24 Jan 2001 10:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131412AbRAXPyl>; Wed, 24 Jan 2001 10:54:41 -0500
Received: from luthien.mozcom.com ([202.47.132.42]:23301 "EHLO
	luthien.mozcom.com") by vger.kernel.org with ESMTP
	id <S131240AbRAXPya>; Wed, 24 Jan 2001 10:54:30 -0500
Date: Wed, 24 Jan 2001 23:54:02 +0800 (PHT)
From: Orlando Andico <orly@mozcom.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 destroys filesystems with VIA IDE driver..
Message-ID: <Pine.LNX.4.21.0101242350440.22458-100000@luthien.mozcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just read kernel traffic (I'm not subscribed to lk) re: Tobias
Ringstrom's FS corruption on 2.4.0.

I'm currently using 2.4.0+ReiserFS 3.6.25 on Red Hat 6.2, on a VIA IDE
main board (ASUS cuv4x, with the 82c686a south bridge) and I have *not*
gotten anything like what Tobias experienced. I manually set up the IDE
drive with hdparm to run at udma(66) mode.

OTOH, I'm using modutils-2.4.0 and my sound module (au8830.o from
aureal.sourceforge.net) is not loading automagically although soundcore.o
does load, it used to under 2.2.18 and i consider this a bug.  :)



---------------------------------------------------------------------
Orlando Andico <orly@mozcom.com>       POTS Phone: +63   (2) 937-2293
Mosaic Communications, Inc.            GSM Mobile: +63 (917) 531-5893
I'm not suffering from insanity -- I'm enjoying  every minute of it!!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
