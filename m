Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283542AbRK3OXg>; Fri, 30 Nov 2001 09:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283540AbRK3OX1>; Fri, 30 Nov 2001 09:23:27 -0500
Received: from ns.conwaycorp.net ([24.144.1.3]:20409 "HELO mail.conwaycorp.net")
	by vger.kernel.org with SMTP id <S283542AbRK3OXP>;
	Fri, 30 Nov 2001 09:23:15 -0500
Date: Fri, 30 Nov 2001 08:23:06 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011130082306.A8439@conwaycorp.net>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130114506.A4789@bee.lk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(forgot to cc lkm on my reply)

> Has anybody got the same issue with non Dell machines?

All I have to test with are Dell machines, so I haven't been able to
try. 

> I am running 2.4.16 on a Compaq proliant ML 370 without problems (machine has
> been up for 2+ days with the new kernels, though).  Trafic is not very high.

The trigger seems to be a combination of high network load, and high
system load.  The times it's happened to me, it's been while running
an app that has a couple of hundred threads, uses about a gig and a
half or so of memory, and does pretty heavy disk and network I/O.  I'm
still trying to find a job that can reproduce it reliably (or even
semi-reliably), and when I can, I'm going to try a switch over to the
e100 driver as some people have suggested, to see if that stops it
from happening.

-- 
Nathan <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

"Competitiveness: the 8th deadly sin."
--Phantom
