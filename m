Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314407AbSD0TYN>; Sat, 27 Apr 2002 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314409AbSD0TYM>; Sat, 27 Apr 2002 15:24:12 -0400
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:56327
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S314407AbSD0TYL>; Sat, 27 Apr 2002 15:24:11 -0400
Date: Sat, 27 Apr 2002 14:22:16 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Thrapp <rthrapp@sbcglobal.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204271406010.11653-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Alan Cox wrote:
> How about
>
> Warning: The module you have loaded (%s) does not seem to have an open
> 	 source license. Please send any kernel problem reports to the
> 	 author of this module, or duplicate them from a boot without
> 	 ever loading this module before reporting them to the community
> 	 or your Linux vendor

I think you're making an assumption about the vendor's support statement
that may not be valid. If I were a distro I wouldn't appreciate modutils
makeing statements about my support policies and confusing the newbies,
who are after all the target audience here. I'd take that last "or your
Linux vendor." bit off of this.

Note that this wouldn't be an issue if no one shipped modules that taint
the kernel, however, I've seen modules on cds for two of the major distros
that would taint the kernel lately. (drivers/cdrom/cdrom.c was just
recenly corrected for example.) Of course if *no one* shipped modules that
taint the kernel then this whole thing wouldn't be an issue. :)

-- 
Never make a technical decision based upon the politics of the situation.
Never make a political decision based upon technical issues.
The only place these realms meet is in the mind of the unenlightened.
			-- Geoffrey James, The Zen of Programming

