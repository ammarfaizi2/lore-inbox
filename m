Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSGOQYB>; Mon, 15 Jul 2002 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317528AbSGOQYA>; Mon, 15 Jul 2002 12:24:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23291 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317525AbSGOQX7>; Mon, 15 Jul 2002 12:23:59 -0400
Subject: Re: HZ, preferably as small as possible
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <agtl95$ihe$1@penguin.transmeta.com>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> 
	<agtl95$ihe$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 09:26:53 -0700
Message-Id: <1026750413.939.97.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 22:06, Linus Torvalds wrote:

> I've never had good reason to believe the latency/perf benefits myself,
> but I was approached at OLS about problems with something as simple as
> DVD playing, where a 100Hz timer means that the DVD player ends up
> having to busy-loop on gettimeofday() because it cannot sanely sleep due
> to the lack in sufficient sleeping granularity.

A cleaner solution to this issue is a higher resolution timer, e.g. the
high-res-timers project which has high resolution POSIX timers.

We could still bump HZ, of course...

	Robert Love

