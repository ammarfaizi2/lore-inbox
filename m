Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVHBHK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVHBHK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVHBHK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:10:58 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:61079 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261344AbVHBHKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:10:52 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 2 Aug 2005 00:10:36 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: tony@muru.com, linux-kernel@vger.kernel.org
Subject: Re: dynamic ticks for 2.6.13-rc4 & bad gzip
Message-ID: <20050802071035.GF15903@atomide.com>
References: <200508021124.15670.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508021124.15670.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050801 18:24]:
> Hi Tony, LKML
> 
> Since there appears to be renewed interest of late in dynamic ticks...
> 
> You didn't respond with my last patch for dynamic ticks so I assume that's 
> because you threw up when you saw what a mess it is. Anyway I'm sorry for 
> sending you that naive mess the first time around. 

Hehe, my strategy of lame response and sloppy patches seems to be working
then! :)

> Here is a full patch for 2.6.13-rc4 pushing code out of common paths and into 
> dyn-tick.h where possible that builds on any config I can throw on it so far. 
> I'm having trouble with "bad gzip magic" on boot with this one so I'm not 
> really sure what's going on. Perhaps someone on the mailing list can shed 
> some light on it.

Thanks a lot, I really appreciate help on getting this thing cleaned up for
x86 + PPC. The ARM version is already merged to mainline, but that's did
not have all the legacy issues, and ARM has nice sys_timer...

I'll try out your patch today at some point, and will post a merged patches
that also integrate the PPC support.

I don't understand the "bad gzip magic", that happens while uncompressing
before kernel boots, right?

Regards,

Tony
