Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSFTUoT>; Thu, 20 Jun 2002 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSFTUoS>; Thu, 20 Jun 2002 16:44:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10368 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S315485AbSFTUoR>; Thu, 20 Jun 2002 16:44:17 -0400
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
From: "Timothy D. Witham" <wookie@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Sandy Harris <pashley@storm.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020620171006.GV22961@holomorphy.com>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
	<m1d6umtxe8.fsf@frodo.biederman.org>
	<20020619222444.A26194@work.bitmover.com> <3D11F7B9.27C74922@storm.ca> 
	<20020620171006.GV22961@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 13:42:55 -0700
Message-Id: <1024605775.1997.3.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another point is that I've seen large multi-user machines that roll
a 32 bi pid in less than 1/2 hour. So not only is it a large
number of process but also a very dynamic process environment.

Tim

On Thu, 2002-06-20 at 10:10, William Lee Irwin III wrote:
> On Thu, Jun 20, 2002 at 11:41:45AM -0400, Sandy Harris wrote:
> > For large multi-processor systems, it isn't clear that those matter
> > much. On single user systems I've tried , ps -ax | wc -l usually
> > gives some number 50 < n < 100. For a multi-user general purpose
> > system, my guess would be something under 50 system processes plus
> > 50 per user. So for a dozen to 20 users on a departmental server,
> > under 1000. A server for a big application, like database or web,
> > would have fewer users and more threads, but still only a few 100
> > or at most, say 2000.
> 
> Certain unnameable databases like to have 2K processes at minimum and
> see task counts soar even higher under significant loads.
> 
> Also, the scholastic departmental servers I've seen in action generally
> host 300+ users with something less than 50/logged in user and something
> more than 50 for the baseline. For the school-wide one I used hosting
> 10K+ (40K+?) users generally only between 500 and 2500 (where the non-rare
> maximum was around 1500) are logged in simultaneously, and the task/user
> count was more like 5-10, with a number of them (most?) riding at 2 or 3
> (shell + MUA or shell + 2 tasks for rlogin to elsewhere). The uncertainty
> with respect to number of accounts is due to no userlists being visible.
> 
> I can try to contact some of the users or administrators if better
> numbers are needed, though it may not work as I've long since graduated.
> 
> Cheers,
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

