Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263557AbRFRHGY>; Mon, 18 Jun 2001 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbRFRHGP>; Mon, 18 Jun 2001 03:06:15 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:16090 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S263557AbRFRHGE>;
	Mon, 18 Jun 2001 03:06:04 -0400
Date: Mon, 18 Jun 2001 09:05:51 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: very strange (semi-)lockups in 2.4.5
Message-ID: <Pine.GSO.4.30.0106180858001.18443-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all.

I'm having ~2 lockups a day. The following happens:
 If I was under X, i only can use the magic-key, but no other keyboard (eg
numlock) or mouse response, the screen freezes, processes stop.
 If i was using textmode:
  numlock still works
  cursor blinks
  processess stop (eg, gpm doesn't work, outputs freeze)
  i can still switch vt's.
  BUT, i can only type into a few vt's, last time into 3,5,6,7,8, but not
into 1,2 or 4!

I cannot give you any traces, as i dont have any.

Also note that magic-key works, and it says that it umounts filesystems if
i press magic-u, but next time at mount i see that reiserfs is replaying
transactions.


Any ideas?

The machine is a P3-750, 512M ram, abit vp6 mb. No overclocking, and it
passes memtest86.


Balazs Pozsar.
-- 


