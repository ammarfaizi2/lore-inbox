Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCKUaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCKUaD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCKU2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:28:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:26256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVCKTT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:19:56 -0500
Date: Fri, 11 Mar 2005 11:19:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050311191928.GK5389@shell0.pdx.osdl.net>
References: <20050309235716.GZ3163@waste.org> <4231E75A.4090203@tmr.com> <20050311190825.GW3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311190825.GW3120@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> Or do you want to do it the same way you do for every other branch? I
> don't want to special-case it in my code and I don't think users want
> to special-case it in their brains. Have separate interdiffs on the
> side, please, and then people can choose, but do it the standard way.
> 
> Dear ${SUCKER}s, can we have a decision on this? My ketchup tool is
> broken for 2.6.11.2 and I don't want to cut a new release until a firm
> decision is made. Obviously I have a strong preference for all 2.6.x.y
> diffs being against 2.6.x, it means that .y can be treated the same as
> -rc, -bk, -mm, ... (and I already coded it that way when 2.6.8.1 came
> out).

I agree with having the patch be against .x, with x.y -> x.y+1 interdiffs
available on the side.  Greg, any issue with that?

thanks,
-chris
