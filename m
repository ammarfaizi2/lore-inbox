Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbRE0RnJ>; Sun, 27 May 2001 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262842AbRE0Rm7>; Sun, 27 May 2001 13:42:59 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:42764 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S262838AbRE0Rmx>; Sun, 27 May 2001 13:42:53 -0400
Message-ID: <3B113CBE.CC07868D@supelec.fr>
Date: Sun, 27 May 2001 19:43:26 +0200
From: francois.cami@supelec.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: Jaswinder Singh <jaswinder.singh@3disystems.com>, stepken@little-idiot.de,
        linux-kernel@vger.kernel.org
Subject: Re: IDE Performance lack !
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527183207.B21206@unthought.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The answer for both of you is:
> 
>   hdparm -d1 /dev/hd{whatever}
> 
> Without DMA enabled, performance is going to suck.  1.9 MB/sec is actually pretty
> good without DMA   ;)

I agree.

I get around 4MB/s without and 35.75MB/s with...
hdparm -c3 -d1 -m16 /dev/hda
on a KT133 (A7V) and 45GB IBM DTLA hard drive.

no data corruption, even with a sblive, an scsi
adapter, 2 hard drives...

François Cami 

> --
> .................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
> -

-- 

All that is gold does not glitter,
	Not all those who wander are lost,
The old that is strong does not wither,
	Deep roots are not touched by the frost.
>From the ashes a fire shall be woken,
	A light from the shadows shall spring,
Renewed shall the blade that was broken,
	The crownless again shall be king.

		The Riddle of Strider
		JRR Tolkien
