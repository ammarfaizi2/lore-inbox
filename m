Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317313AbSFGSHO>; Fri, 7 Jun 2002 14:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSFGSHN>; Fri, 7 Jun 2002 14:07:13 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:59020 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317313AbSFGSHN>; Fri, 7 Jun 2002 14:07:13 -0400
Date: Fri, 7 Jun 2002 12:06:58 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH][2.5] tulip: change device names
In-Reply-To: <3D00F47C.3000801@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0206071203580.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Jun 2002, Jeff Garzik wrote:
> Thanks for the effort, that was a quick turnaround :)
> 
> But unfortunately the patch is wrong.
> 
> You need to use an index which counts _tulip_ boards, which implies that 
> the index is local to the driver.  Currently the only such counter is 
> board_idx, which is a variable local to tulip_init_one().

Would you suggest

a) setting it in some global struct (tulip_private etc.)?
b) calling it "eth%d", dev->ifindex?

> I wonder who the heck this patch is from??  Mikael?  The "Lightweight 
> patch manager" seems neat, but a rather unfriendly person to reply to :)

You keep talking to me. It happens whenever I use sendpatch. I prefer not 
to be determined as sender of my patches by grepping the list, but all 
responses to patch@etc go to thunder@etc, which is me.

> Regards,
> 
>     Jeff


> P.S. A ChangeLog entry (in the patch, or to be cut-n-pasted) is missing 
> also.

What do you suggest?

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

