Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRGHMtj>; Sun, 8 Jul 2001 08:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266883AbRGHMt3>; Sun, 8 Jul 2001 08:49:29 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:24303 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S266867AbRGHMtV>; Sun, 8 Jul 2001 08:49:21 -0400
Date: Sun, 8 Jul 2001 22:49:30 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: synaptics touchpad not working with 2.4.x
Message-ID: <20010708224930.B723@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I;ve had this with 2.4.0 but have just tried with 2.4.6ac2 and still
have it.

Under 2.2.x the touchpad works like a dream. Under 2.4.x it stutters,
freezes and so on. Did something about /dec/psaux change between 2.2.x
and 2.4.x? Will I need to recompile glibc and/or gpm?

if I cat /dev/psaux I get data flowing through but gpm stays frozen. :/

Hope someone can help as, now that ext3 is being well and truly ported 
to 2.4.x, this is the last stumbling block for me having 2.4.x on
my laptop.

gpm options: /usr/sbin/gpm -m /dev/psaux -t synps2 -Rmsc -2
glibc: 2.1.3 compiled for 2.2.x

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

