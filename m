Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131272AbRCHFMz>; Thu, 8 Mar 2001 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131274AbRCHFMp>; Thu, 8 Mar 2001 00:12:45 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:12554 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S131272AbRCHFMc>;
	Thu, 8 Mar 2001 00:12:32 -0500
Message-ID: <3AA71B5C.5AD8661E@candelatech.com>
Date: Wed, 07 Mar 2001 22:40:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No
In-Reply-To: <E14adVH-0000wL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm not arguing it was a smart thing to do, but I would think that the
> > fs/kernel/driver writers could keep really nasty and un-expected things
> > from happenning.  For instance, the driver could dis-allow any new (non-hdparm)
> 
> Like stopping root from using rm -r ? Where is the line drawn

rm -r does not do un-expected things, and it does not corrupt your file
system, it merely removes it.  That is the only thing it does, and it
does it every time.

However, messing with the hdparms options can do random things, at
least from my perspective as a user:  It may bring exciting new performance
to your system, and it may subtly, or not so, corrupt your file system.

If the drivers can detect what type of HD/chipset we are using, surely
it can know not to allow the user to do stupid things that are out of
spec w/regards to the hardware?

For the power/insane user, there could be a --really-do-stupid-thing-i-told-you-to
option, and it should be that hard to type!!

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
