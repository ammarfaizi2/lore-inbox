Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272234AbRIESKC>; Wed, 5 Sep 2001 14:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272235AbRIESJw>; Wed, 5 Sep 2001 14:09:52 -0400
Received: from anime.net ([63.172.78.150]:54290 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S272234AbRIESJj>;
	Wed, 5 Sep 2001 14:09:39 -0400
Date: Wed, 5 Sep 2001 11:07:20 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: noneuclidean <noneuclidean@ziplip.com>
cc: <linux-kernel@vger.kernel.org>, <redelm@ev1.net>
Subject: RE: Athlon doesn't like Athlon optimisation?
In-Reply-To: <JK3MT4ZNAEJNIG1ZEGEDMAZMT10XZKMHVJEFFMME@ziplip.com>
Message-ID: <Pine.LNX.4.30.0109051105190.14146-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2001, noneuclidean wrote:
> I have an Iwill KK266 (VIAKT133A chipset, latest BIOS) with an unlocked but not overclocked Athlon 950 (AMD Thunderbird, A4, Model 4). The system DOES suffer the Athlon optimisation problem.
> I ran burnK7, burnK7 in linux 2.4.8ac11 (optimised for K6) and WinME for over 3 hours with no problems.
> For ?fun? I also tried running 50 mulitiple instances (in total) of a mix of burnK7, burnMMX, burnBX, burnP6 and burnK6 in linux (with different memory settings for burnBX and burnMMX), while accessing floppy, CD-ROM, 2xHDDs, my SBLive card and my Geforce 2 to try and load my voltages... but again completely stable, if a bit... well very... jerky!.
> I think the burnK7 program does not test enough K7 specific instruction sets to find the problem.

burnK7 doesnt test enough ram to expose the problem. burnK7 stays entirely
inside cache and doesnt touch main memory, which is where the problem
everyone is having is.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

