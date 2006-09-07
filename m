Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWIHNoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWIHNoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIHNoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:44:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20486 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751117AbWIHNoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:44:21 -0400
Date: Thu, 7 Sep 2006 19:31:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: lamikr <lamikr@cc.jyu.fi>
Cc: tony@atomide.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Message-ID: <20060907193140.GH8793@ucw.cz>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com> <44FF2A6D.3000500@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FF2A6D.3000500@cc.jyu.fi>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> now Tux can finally call home :-)
> >>     
> >
> > Cool that you got the phone features working :)
> >   
> Yes,  and gprs is also working nicely with the pppd so I can finally
> start eating dog food :-)
> Some problems there still are
> 
> 1) As we do not yet have any kind of multiplexing support to gsm module
> (currently directly accesing dev/ttyS1 for at commands)
> our phone app is not able to run simultaneously with the ppp. I am not
> sure should I resolve this in the kernel space or user space.

Userspace, I'd say. I've seen that package (google for gsm 07.14,
IIRC), but could not get it to work.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
