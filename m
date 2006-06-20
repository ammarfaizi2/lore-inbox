Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWFTMQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWFTMQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWFTMQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:16:19 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:17423 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932614AbWFTMQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:16:18 -0400
Date: Tue, 20 Jun 2006 22:17:10 +1000
From: CaT <cat@zip.com.au>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060620121710.GA2059@zip.com.au>
References: <20060619020040.GX2059@zip.com.au> <20060620005405.GY2059@zip.com.au> <20060620100209.GA4566@redhat.com> <20060620114613.GZ2059@zip.com.au> <20060620115545.GB4566@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620115545.GB4566@redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:55:45PM +0200, Heinz Mauelshagen wrote:
> On Tue, Jun 20, 2006 at 09:46:13PM +1000, CaT wrote:
> > On Tue, Jun 20, 2006 at 12:02:09PM +0200, Heinz Mauelshagen wrote:
> > > How many snapshots active at once ?
> > 
> > 1. I can start more then 1 premade snapshots just fine and use them
> > but the moment I add another one a freeze occurs.
> 
> Well, that's fairly few ;)

Yes. I thought so too. :)

> > > I guess this is a kcopyd scalability issue which needs addressing.
> > 
> > Well in the end I'm hoping to get at least 7. Hopefully that's not
> > insane. :)
> 
> No, I was assuming, you were trying to activate plenty.

Not yet. Though as I said I plan to max out at 7 or so.

> FYI: the snapshot code in 2.6.17-rc has received a fair amount of fixes
>      which might help this vs. 2.6.16.20.

I tried 2.6.17 and I get the same issue. Any other kernel you want me to
try? I can reboot this box at will at the moment and test.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
