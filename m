Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946296AbWBDELG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946296AbWBDELG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 23:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946302AbWBDELG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 23:11:06 -0500
Received: from [205.233.219.253] ([205.233.219.253]:60896 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1946296AbWBDELF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 23:11:05 -0500
Date: Fri, 3 Feb 2006 23:08:58 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Ben Collins <ben.collins@ubuntu.com>
Subject: Re: ieee1394/oui.db (was Re: [PATCH] ieee1394: allow building with absolute SUBDIRS path)
Message-ID: <20060204040858.GG22002@conscoop.ottawa.on.ca>
References: <1138234743.10202.3.camel@localhost> <20060131052101.GC9667@conscoop.ottawa.on.ca> <43DFC648.4030404@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DFC648.4030404@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 09:19:20PM +0100, Stefan Richter wrote:
> 
> I have no strong feelings for or against oui.db. It is nice to have the 
> vendor names decoded in sysfs, although the footprint is considerable:

I guess it's nice (I've never compiled it in until a few days ago mind
you) but this type of thing is userland's job.  I've been meaning to
write a good ls1394 for some time now.  I have one that's too crappy to
release :)

> $ du oui.o ieee1394.ko
> 252K    oui.o
> 356K    ieee1394.ko
> 
> OTOH, nobody is forced to compile it in. And except for the Makefile 
> patch and .gitignore patch which came in this month, oui.db does not 
> impose a real maintenance burden. The fact that we are too lazy to 
> update the db saves us work too. :-)

No, it doesn't, but its existance offends me :)

I don't care deeply though.  If people want it, I'll live with it being
in.

Cheers,
Jody


> BTW, oui.db has 7048 entries but IEEE lists 8949 today. Either people 
> vote oui.db off the island now, or I will submit an update.
> -- 
> Stefan Richter
> -=====-=-==- ---= =====
> http://arcgraph.de/sr/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
