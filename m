Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSG0QBG>; Sat, 27 Jul 2002 12:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318780AbSG0QBG>; Sat, 27 Jul 2002 12:01:06 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:9344 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S318778AbSG0QBF>; Sat, 27 Jul 2002 12:01:05 -0400
Date: Sat, 27 Jul 2002 18:11:27 +0200
Organization: Pleyades
To: vherva@niksula.hut.fi, raul@pleyades.net
Subject: Re: About the need of a swap area
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D42C62F.mail5XQ31DIAC@viadomus.com>
References: <3D42907C.mailFS15JQVA@viadomus.com>
 <20020727144228.GQ1548@niksula.cs.hut.fi>
In-Reply-To: <20020727144228.GQ1548@niksula.cs.hut.fi>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Ville :)

>>     I read a time ago that, no matter the RAM you have, adding a
>> swap-area will improve performance a lot. So I tested.
>Well, no. I don't know where you read it, but that's wrong.

    I don't remember clearly. Maybe at linux-gazette or someplace
like that. Moreover, maybe I take the phrase out of context.

>Where swap helps perfomance is when you can swap _inactive_ (parts of)
>programs out, and use the freed memory for disk cache.

    Yes, that makes sense, obviously. My question is more: when an
inactive page will be swapped out? Only when there is no more RAM
left? When free RAM goes below some point? How to configure it?

>> the memory is not prone to be filled.
>So you have 512MB of RAM? All the programs (without X) will fit
>there easily. You'll still have plenty for disk cache.

    Except when I'm compiling something large, the memory is almost
entirely free. I have a lot of memory for having a lot of cache, so
when I develope things go real fast. For example, I use gcc, make and
binutils (and an editor) most of the time. Well, thanks to the disk
cache, the first time they are run is the only disk access...

    Moreover, sometimes I use ram disks.

>BUT: if something unexpected happens - a programs goes out of
>control and eats heaps of memory - the swap can save you.

    But in such a case, highs are the chances of the program crashing
due to a memory error if there is no swap. I really don't understan
why swap may save me in this case O:)) Maybe the swap-in, swap-out
will make that process slower and I have some spare CPU to be able to
kill the program?

>Hope this helps.

    Yes, thank you :))
    Raúl
