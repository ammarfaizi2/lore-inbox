Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281248AbRKMAPi>; Mon, 12 Nov 2001 19:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRKMAP3>; Mon, 12 Nov 2001 19:15:29 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:12036 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281248AbRKMAPQ>;
	Mon, 12 Nov 2001 19:15:16 -0500
Message-Id: <5.1.0.14.0.20011113105444.009f3ec0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 13 Nov 2001 11:15:11 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS630 and 5591/5592 AGP
Cc: Gavin Baker <gavbaker@ntlworld.com>
In-Reply-To: <20011112163604.A5384@box.penguin.power>
In-Reply-To: <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>
 <20011111185930.A2700@box.penguin.power>
 <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:36 PM 12/11/01 +0000, Gavin Baker wrote:
>Im currently using vesa for X, I would like to get some kind of 
>acceleration to play DVD's etc. I've tried the sis_drv in X 4.1 with the 
>lavalamp style effect i mentioned, the sis driver in X3.x gets the screen 
>offset totally wrong, ie the center of the screen is on the far right of 
>the physical screen, but this is a problem i can direct to the X lists.

You'll find a post from me there back in October, and a patch to X (and a 
binary module) linked to. The files are still there, and contains details 
on how to try the work-around.

> > Alan has new drivers in his ac tree. but I've tried them, and no luck.
> > Give them a shot and see how you go. You might be lucky.
>
>This is on 2.4.13-ac8, sisfb also messes up the screen offset,
>CONFIG_AGP_SIS is turned off as Configure.help mentions it doesn't
>support the 5591/5592.



>This is an "Advent 5490", which i think is Pc-World(tm)'s own brand name 
>they've applied to an oem laptop made by someone else, but i could have 
>this the wrong way around/totally wrong. It's a 900mhz 
>celeron  (coppermine), SiS everything.

Probably a Clevo, they make a lot of notebooks. Then again, you never know.

>Im sure other laptops with different badges on them will have the same
>internals.

Gotta love reference designs.

>Everything else (except the software modem, which i have no use for)
>worked straight out of the tin with RedHat 7.2's vanilla kernel. Im
>current using Alans 2.4.13-ac8:

The sisfb driver changes appeared in 2.4.13-ac4, so I'd guess they'd be in 
2.4.13-ac8. Unfortunately (afaik) Alan hasn't gotten much in the way of 
e-mail response from SiS on his questions. The driver made an appearance 
early in the 2.4 series, and was 'reverted' back to the old one as SiS 
didn't respond to questions about the code, which afaik seemed "inconsistent".

Can you e-mail me (may as well be off-list) the dump of 'lspci -bv' please? 
I'm interested in checking up on the revision differences between our 
chipsets. Should give me something to start with on the audio front, and 
hopefully on the video front I can get the same info from people without 
problems, so I can figure out what revisions have this problem. Any others 
who either have this video problem, or don't have it (SiS630 chipsets only 
at the moment, and I know a few people are keeping an eye out for topics 
with SiS630 in them like I am), feel free to e-mail me your output from 
'lspci -bv' as well. The more info I get, the more likely we can narrow 
this down.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

