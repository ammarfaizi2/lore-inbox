Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267132AbUBSJl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267099AbUBSJl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:41:57 -0500
Received: from mail.daysofwonder.com ([209.61.173.130]:14525 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S267132AbUBSJld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:41:33 -0500
Subject: Re: PROBLEM: spurious temporary freeze, scheduler and preempt
	problem ?
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Cc: Eric <eric@cisu.net>, Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <403402DE.4030400@cyberone.com.au>
References: <1077117976.2265.61.camel@localhost.localdomain>
	 <200402181212.06279.eric@cisu.net>  <403402DE.4030400@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1077183691.2058.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Thu, 19 Feb 2004 10:41:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, Nick,

On Thu, 2004-02-19 at 01:27, Nick Piggin wrote:
> Eric wrote:
> 
> >On Wednesday 18 February 2004 9:26 am, Brice Figureau wrote:
> >Someone correct me if I'm way off base, but have you tried
> >	scheduler=deadline
> >To try the different kernel schedulers?
> >Im not sure about the keyword, but do a quick google or search lkml and you'll 
> >see the correct keyword and the different schedulers you can try.
>
> It's probably a CPU scheduler related problem, so this
> wouldn't do much.

Yes it is more a CPU scheduler problem, than an io one (although I
tested with elevator=deadline just to be sure ;-) and I had the same
problem).

--
Brice Figureau

