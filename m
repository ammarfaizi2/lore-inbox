Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVCKWp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVCKWp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCKWoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:44:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:39908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261532AbVCKWgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:36:45 -0500
Date: Fri, 11 Mar 2005 14:01:50 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Bill Davidsen <davidsen@tmr.com>,
       Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050311220150.GA4925@kroah.com>
References: <20050309235716.GZ3163@waste.org> <4231E75A.4090203@tmr.com> <20050311190825.GW3120@waste.org> <20050311191928.GK5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311191928.GK5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 11:19:28AM -0800, Chris Wright wrote:
> * Matt Mackall (mpm@selenic.com) wrote:
> > Or do you want to do it the same way you do for every other branch? I
> > don't want to special-case it in my code and I don't think users want
> > to special-case it in their brains. Have separate interdiffs on the
> > side, please, and then people can choose, but do it the standard way.
> > 
> > Dear ${SUCKER}s, can we have a decision on this? My ketchup tool is
> > broken for 2.6.11.2 and I don't want to cut a new release until a firm
> > decision is made. Obviously I have a strong preference for all 2.6.x.y
> > diffs being against 2.6.x, it means that .y can be treated the same as
> > -rc, -bk, -mm, ... (and I already coded it that way when 2.6.8.1 came
> > out).
> 
> I agree with having the patch be against .x, with x.y -> x.y+1 interdiffs
> available on the side.  Greg, any issue with that?

No, I agree with that, and will not be hard to do at all (the release
script already handles this just fine.)  

I've held off rediffing 2.6.11.2 so far, as I don't know where to put
the x.y+1 interdiffs?  kernel/v2.6/incr/ ?  Any thoughts?

thanks,

greg k-h
