Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbTHVIzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTHVIzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 04:55:31 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:34953 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S263086AbTHVIz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 04:55:26 -0400
Date: Fri, 22 Aug 2003 10:55:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030822085508.GA10215@k3.hellgate.ch>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F4182FD.3040900@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4182FD.3040900@cyberone.com.au>
X-Operating-System: Linux 2.6.0-test3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 11:53:01 +1000, Nick Piggin wrote:
> I haven't run many tests on it - my mind blanked when I tried to
> remember the scores of scheduler "exploits" thrown around. So if
> anyone would like to suggest some, or better still, run some,
> please do so. And be nice, this isn't my type of scheduler :P

I timed a pathological benchmark from hell I've been playing with lately.
Three consecutive runs following a fresh boot. Time is in seconds:

2.4.21			821	21	25
2.6.0-test3-mm1		724	946	896
2.6.0-test3-mm1-nick	905	987	997

Runtime with ideal scheduling: < 2 seconds (we're thrashing).

If anybody has thrashing test cases closer to the real world, I'd be very
interested to learn about them.

Roger
