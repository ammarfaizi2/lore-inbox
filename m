Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHRJJf>; Sun, 18 Aug 2002 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSHRJJe>; Sun, 18 Aug 2002 05:09:34 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:38610 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S313070AbSHRJJd>; Sun, 18 Aug 2002 05:09:33 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020818090000.GA5154@ip68-4-77-172.oc.oc.cox.net>
References: <1029653085.674.53.camel@psuedomode>
	<1029655603.2970.6.camel@psuedomode> 
	<20020818090000.GA5154@ip68-4-77-172.oc.oc.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 05:13:33 -0400
Message-Id: <1029662014.2966.19.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 05:00, Barry K. Nathan wrote:
> On Sun, Aug 18, 2002 at 03:26:42AM -0400, Ed Sweetman wrote:
> > Ok, i reran the test with a little process of elimination.
> > The problem occurs only when dma is enabled on the promise controller's
> > harddrive. 
> [snip]
> 
> Looking at your dmesg, it seems you're using a Promise controller on a
> VIA chipset. AFAIK this is a known problem and the only known solution
> is to avoid the VIA/Promise combo.

there are a lot less bug reports than would be seen if it was strictly a
hardware problem. Promise controllers are by far the most popular and
readily available addon controllers and the amount of people using via
chipsets is significant for such a hardware problem to make a lot more
than a handful of people post problems directly related to the fact that
they use promise controllers on a via chipset. You'd get a lot of people
screaming and yelling.   It could just as easily be the promise driver
used with the via chipset.  The only people who know are those that work
with the ide drivers and hardware.  Are we dealing with a fundemental
flaw with via and promise combos or some driver bug ?   

as for the solution, it's not a solution unless it's strictly a hardware
conflict which i doubt.  That is, unless you know a place that trades
ide controllers and will take my promise controller and give me one that
works at equivalant speeds that the promise would have.  


assuming there aren't any such places.  I'm looking for real pointers as
to what's going on and how to fix it, not ways to avoid problems.  I
have ways to avoid the problem, they're not solutions to the problem
though. Thanks anyways. 

