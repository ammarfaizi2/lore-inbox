Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQLHSHu>; Fri, 8 Dec 2000 13:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132457AbQLHSHo>; Fri, 8 Dec 2000 13:07:44 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:21007 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S131696AbQLHSHb>; Fri, 8 Dec 2000 13:07:31 -0500
Date: Fri, 8 Dec 2000 18:36:42 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.2.18pre25
In-Reply-To: <E144RCQ-0004Ba-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012081820420.7409-100000@duck.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Alan Cox wrote:

# >    Is there any chance to get rid of these VMM failures?
# By finding them.

   :-) I am not so familiar with MM in Linux. :^(
   And do not have enough time for intensive study...
   Although I would probably like that work...

# Are you confident you are not running out of memory.

   Well, almost sure. This is the log with load records:

                                                   (according to /proc/meminfo)
                              FTPusers SMBusr load      free mem    free swap
Fri Dec  8 14:35:05 CET 2000      61      35 6.17        3068 kB     128932 kB
Fri Dec  8 14:40:04 CET 2000      59      36 5.05        2280 kB     130320 kB
Fri Dec  8 14:45:03 CET 2000      59      36 5.97        2896 kB     131448 kB
Fri Dec  8 14:50:03 CET 2000      59      35 6.59        2908 kB     133140 kB
Fri Dec  8 14:55:04 CET 2000      53      36 8.82        2380 kB     133952 kB
Fri Dec  8 15:00:03 CET 2000      53      40 6.42        2728 kB     135064 kB
Fri Dec  8 15:05:03 CET 2000      48      39 5.47        2264 kB     135684 kB
Fri Dec  8 15:10:03 CET 2000      48      41 3.90        3204 kB     135928 kB
Fri Dec  8 15:15:03 CET 2000      51      41 5.93        2628 kB     135700 kB
Fri Dec  8 15:20:03 CET 2000      50      45 6.50        2124 kB     135828 kB
Fri Dec  8 15:25:03 CET 2000      56      44 7.92        2192 kB     136080 kB
Fri Dec  8 15:30:03 CET 2000      49      45 10.89        2072 kB     136176 kB
Fri Dec  8 15:35:03 CET 2000      51      42 6.32        2960 kB     136156 kB
Fri Dec  8 15:40:04 CET 2000      54      44 6.92        2364 kB     136220 kB
Fri Dec  8 15:45:03 CET 2000      54      44 6.63        2852 kB     136348 kB
Fri Dec  8 15:50:04 CET 2000      53      46 3.63        2248 kB     136420 kB
Fri Dec  8 15:55:03 CET 2000      59      48 6.51        3060 kB     136312 kB
(crashed during the next 5 minutes)

   Doesn't seem to have consumed all of swap space.
   I will try to determine more info the next time - I promise...

# Presumably since 2.2.13 works you are 8)

   I didn't tell it worked. It had worked a long time ago.
   It is still not tested now. Unfortunately, due to the absence of raid0
module the bootup process destroyed our 140GB partition. It will take some
time to make the system running again. :-(

   Thank for your answer anyway...
   Martin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
