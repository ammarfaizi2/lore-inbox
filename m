Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263733AbRFDOzh>; Mon, 4 Jun 2001 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264302AbRFDOwq>; Mon, 4 Jun 2001 10:52:46 -0400
Received: from wdskppp2.mpls.uswest.net ([63.226.148.2]:16234 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264301AbRFDOwf>; Mon, 4 Jun 2001 10:52:35 -0400
Date: Mon, 4 Jun 2001 09:39:21 -0500 (CDT)
From: Nitebirdz <nitebirdz@qwest.net>
X-X-Sender: <nitebirdz@localhost.localdomain>
To: Peter Rasmussen <plr@udgaard.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap problems persisting?
In-Reply-To: <200105300442.GAA01571@udgaard.com>
Message-ID: <Pine.LNX.4.33.0106040933510.20186-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Peter Rasmussen wrote:

>
> By "sudden shutdown" I meant that the machine freezes hard and when running X
> using the Magic SysRq key combinations don't seem to work so power cycling was
> the only option. It seems that it wasn't just the keyboard that had frozen
> because a webserver I'm running on the machine also stopped serving pages.
>
> Thanks,
>
> Peter


I ignore if this has been reported somewhere but I experience the very same
problem _only_ if the "using_dma" flag in hdparm is enabled.  It doesn't
only happen with DVDs, but apparently with several other devices such as
CD-ROMS, playing MP3s, reading from the /dev/pilot device...  My system
also freezes, I cannot access it via the network, I can only reboot and
when I take a look at the logs there is no clue at all as to what might have
happened.  I also have a report from a friend of mine who experienced the
same problem while burning CDs.  It also seemed to ba caused by hdparm.

Are you using hdparm too by any chance?  Can you try to reproduce the
problem _without_ enabling the flag?


Just my 2 cents.  I hope I'm not wasting anybody's time.  Now, I'll shut
up again and read what you guys have to say, as usual.  :-)



-- 
------------------------------------------------------
Nitebirdz
------------------------------------------------------
http://www.linuxnovice.org
News, tips, articles, links...

*** http://www.mozilla.org ***

