Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277487AbRJOMFJ>; Mon, 15 Oct 2001 08:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277485AbRJOME7>; Mon, 15 Oct 2001 08:04:59 -0400
Received: from pD903CA18.dip.t-dialin.net ([217.3.202.24]:20353 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S277496AbRJOMEp>; Mon, 15 Oct 2001 08:04:45 -0400
Date: Mon, 15 Oct 2001 14:05:07 +0200
To: Pascal Schmidt <pleasure.and.pain@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac1: BUG in sched.c:712
Message-ID: <20011015140507.D22287@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.33.0110150401390.911-100000@neptune.sol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110150401390.911-100000@neptune.sol.net>
User-Agent: Mutt/1.3.22i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 04:10:56AM +0200, Pascal Schmidt wrote:
> 
> I just wanted to go to bed and left an ISO image download running in the
> background... well, the blinking leds on the keyboard indicating a kernel
> panic just don't want to let me sleep (yeah, I know 2.4.12-ac1 is
> supposed to be rather experimental).
> 
> No syslog record, so I had to copy the panic output by hand, so now my
> hand hurts AND the info may be inaccurate. ;)

I am very sure that this oops is related to mppp. There seems to be a
bug in the mppp-code which produces exactly this output (the lines with
-1 at the end and then a oops during sceduling). I asked at the
isdn4linux-devel-list but the mppp-code seems to be so dirty that they
think it would be easyer to rewrite it than debugging it. So I think
there will be no fast solution for this problem.
