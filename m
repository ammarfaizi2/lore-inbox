Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbTGEPp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbTGEPp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:45:56 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:16811 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266369AbTGEPpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:45:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 02:01:04 +1000
User-Agent: KMail/1.5.2
References: <20030703023714.55d13934.akpm@osdl.org> <200307050216.27850.phillips@arcor.de> <200307051728.12891.phillips@arcor.de>
In-Reply-To: <200307051728.12891.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307060201.04219.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003 01:28, Daniel Phillips wrote:
> On Saturday 05 July 2003 02:16, Daniel Phillips wrote:
> > It now tolerates window dragging on this unaccelerated moderately high
> > resolution VGA without any sound dropouts.  There are still dropouts
> > while scrolling in Mozilla, so it acts much like 2.5.73+Con's patch, as
> > expected.
>
> Update: dropouts still do occur while moving windows, but rarely.  When
> they do occur, they are severe.  A debian dist-upgrade just caused a
> dropout - and another just now, about 3 seconds long.  I feel that tweaking
> is only going to get us so far with this.  The situation re scheduling in
> 2.5 feels much as the vm situation did in 2.3, in other words, we're
> halfway down a long twisty road that ends with something that works, after
> having tried and failed at many flavors of tweaking and tuning.  Ultimately
> the problem will be solved by redesign, and probably not just limited to
> kernel code.

Have you taken the next twist in the road? I posted a second patch which 
should go on top of what's in 2.5.74-mm1 a couple of days ago. Just in case, 
here is a link to it.

http://kernel.kolivas.org/2.5/

it's called patch-O2int-0307041440

It makes significant headway in smoothing the corner cases. I need testing at 
each point before I can post another update, and am doing much less frequent 
smaller updates now, with the aim of having no more than one patch for each 
-mm, so I can have a decent sized audience for each change.

Andrew can you please apply this one on top in the next -mm if you are to 
continue testing this patch series.

Con

