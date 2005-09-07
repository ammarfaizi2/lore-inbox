Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVIGE1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVIGE1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 00:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVIGE1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 00:27:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:720 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751089AbVIGE1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 00:27:01 -0400
Subject: Re: Kernel profiles anyone?
From: Lee Revell <rlrevell@joe-job.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431E43C8.3030309@comcast.net>
References: <431E43C8.3030309@comcast.net>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 00:26:55 -0400
Message-Id: <1126067216.13159.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 21:35 -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Are there any recent kernel profiles?  I think from an acedemic
> perspective it'd be nice to see some graphs and numbers nobody
> understands showing where the longest running code paths in the kernel
> occur.  It might also be nice for those latency whores (*runs to the
> back and raises hand*) and those who want to increase overall
> performance and efficiency; then there'd be a map showing . . .
> something that only kernel hackers could possibly understand or care about.

There's a latency histogram option in the -rt patch set.  You can pipe
the output through gnuplot and get some cool graphs.  Then you can
use /proc/latency_trace to try and guess what code paths the peaks on
the graphs correspond to.  The timer interrupt will be the biggest peak,
around 23 usecs last time I checked.

I haven't done it lately so it would be interesting to see the current
graphs.  Someone could make a really good presentation out of it at some
kernel development conference.

Lee

