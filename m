Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSKMVWx>; Wed, 13 Nov 2002 16:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKMVWx>; Wed, 13 Nov 2002 16:22:53 -0500
Received: from willow.seitz.com ([146.145.147.180]:31507 "EHLO
	willow.seitz.com") by vger.kernel.org with ESMTP id <S264659AbSKMVWv>;
	Wed, 13 Nov 2002 16:22:51 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Wed, 13 Nov 2002 16:29:39 -0500
To: Jakob Oestergaard <jakob@unthought.net>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: repeatable IDE errors when using SMART
Message-ID: <20021113212939.GA22632@willow.seitz.com>
References: <Pine.LNX.4.44.0211121800320.20949-100000@twinlark.arctic.org> <20021113172610.GA20515@willow.seitz.com> <20021113193930.GJ22407@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113193930.GJ22407@unthought.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 08:39:30PM +0100, Jakob Oestergaard wrote:
> > I have a Maxtor and an IBM; unfortuantely I don't recall which one was
> > bokning out on smartctl...
> > 
> > If it's interesting (and resonably safe) I could do some testing on my
> > system.
> 
> Do you use Promise controllers?
> 
> If so, do you use anything newer than the Ultra33 or Ultra66
> controllers?

Sure do - one controller is the integrated VIA KT133, the second is an
on-board Promise PDC20265.  The Maxtor drive is on the VIA, IBM on
Promise.

It must've been running smartctl on the IBM drive that would bonk my
system - I just tried 'cat /proc/ide/hde/identity' and my machine froze
solid - no numlock, no sysrq, no ping.  The disk access light was on.

I hadn't even considered the different controllers.

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.				 It is a Water Cannon.
He fires Holy-Water from it.			    It is a Holy-Water Cannon.
He Blesses it.				       It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.		It is a Wholly Holy Holy-Water Cannon.
He has it pierced.		  It is a Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.				       He shoots them.
