Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTAYXIJ>; Sat, 25 Jan 2003 18:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTAYXIJ>; Sat, 25 Jan 2003 18:08:09 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:37789 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP
	id <S264867AbTAYXII>; Sat, 25 Jan 2003 18:08:08 -0500
Message-ID: <3E331AA2.38F99839@verizon.net>
Date: Sat, 25 Jan 2003 15:15:46 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rpjday@mindspring.com
Subject: Re: restructuring of filesystems config menu
References: <Pine.LNX.4.33L2.0301132030590.2674-101000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [4.64.236.51] at Sat, 25 Jan 2003 17:17:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Date: Sun, 12 Jan 2003 07:57:33 -0500 (EST)
> From: Robert P. J. Day <rpjday@mindspring.com>
> Subject: restructuring of filesystems config menu
> 
>   i've attached a gzipped patch against 2.5.56 for reorganizing
> the filesystem menu under "make xconfig", and i'm certainly
> open to feedback/comments/criticism/large sums of money.

Good luck with those.  :)

I finally looked at this on 2.5.59.  The fs menu certainly
needs some help/work, so I'd like to see you keep plugging away
at this.  I didn't see much feedback -- was there feedback?
Maybe on a different subject/thread?  A newer version that I
missed?

>   some points about this patch:
> 
> 1) if anyone wants to carefully check the dependencies and
>    make sure they're correct, that would be nice.
> 
> 2) perhaps making sure the dependencies match the claims
>    in the help screens would be helpful.  i noticed that
>    the help screens sometimes make dependency claims that
>    are wildly untrue, but i didn't want to mess with that
>    stuff yet as i wasn't totally comfortable.
> 
> 3) much to my delight, i found out by accident that i can
>    add leading asterisks to menu and config lines with no
>    effect on the eventual config step -- this makes it
>    wonderfully easy to edit and reorganize using emacs
>    outline mode, particularly showing subdependencies.

I find it odd that "help" in a Kconfig file can be spelled
"help" or "---help---", but "--help--" leads to errors.

>    is this just a fluke?  obviously, it's easy enough to
>    strip out the leading asterisks in the final version,
>    but if they're not doing any harm, i'd just as soon
>    leave them in.

I expected to just see the filesystems listed in alpha order,
but I don't have a problem with the groupings that you
have made for them.

Thanks,
~Randy
