Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRIPJiB>; Sun, 16 Sep 2001 05:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRIPJhw>; Sun, 16 Sep 2001 05:37:52 -0400
Received: from [62.54.182.47] ([62.54.182.47]:17164 "EHLO mail.citd.de")
	by vger.kernel.org with ESMTP id <S269693AbRIPJhk>;
	Sun, 16 Sep 2001 05:37:40 -0400
Date: Sun, 16 Sep 2001 11:38:01 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: (2.4.9)kswapd goes haywire
Message-ID: <Pine.LNX.4.20.0109161129001.26325-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi



I have a Dual PIII 933 on a Serverworks HE-SL Chipset Mainboard with 3GB
of RAM. 

I don't have any swap configured and every now and then kswapd goes
haywire and eats the performace of a whole processor (99.9% in top)

I like murphy. Just a second ago kswapd went to 0.0 %. But as you can see
in my uptime and the processtime of kswapd it was haywire for nearly from
the beginning.

-- top --
 11:32am  up 10:19,  7 users,  load average: 0.16, 0.98, 1.09
108 processes: 107 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  1.2% user,  0.3% system,  0.0% nice, 97.4% idle
CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
Mem:  3090704K av, 2404600K used,  686104K free,       0K shrd,  139676K
buff
Swap:       0K av,       0K used,       0K free                 2089512K
cached

    5 root       9   0     0    0     0 SW    0.0  0.0 597:58 kswapd
-- End --

Kernel is 2.4.9 Vanilla

If more information is needed i will provide them.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


