Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313220AbSDJPFP>; Wed, 10 Apr 2002 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDJPDs>; Wed, 10 Apr 2002 11:03:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36870 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313189AbSDJPDc>; Wed, 10 Apr 2002 11:03:32 -0400
Date: Wed, 10 Apr 2002 11:00:56 -0400
Message-Id: <200204101500.LAA31636@gatekeeper.tmr.com>
To: gandalf@winds.org
Subject: Re: Using video memory as system memory
In-Reply-To: <Pine.LNX.4.44.0204091816380.13516-100000@winds.org>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0204091816380.13516-100000@winds.org> you write:
| I have an old 586 that has low memory and no ability for further upgrades.
| I had an idea to use the framebuffer memory of a 32MB video card lying around
| the office as system memory and implemented the following patch:

  I believe I would have been tempted to define that memory as first use
swap or some such, the video memory may have different speed or
something than main memory. Low tech NUMA?

  A lot of the old ISA memory cards could be addressed in that range as
well, allowing even more space. Of course they sell new motherboards
cheaply as well, so that might not be cost effective even at used
prices.

  Intersting hack, though.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
