Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTFMRF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTFMRF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:05:26 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:29174 "EHLO dust")
	by vger.kernel.org with ESMTP id S265406AbTFMRFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:05:20 -0400
Date: Fri, 13 Jun 2003 12:21:11 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uptime wrong in 2.5.70
In-Reply-To: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.56.0306131217530.1228@dust>
References: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Tim Schmielau wrote:

> > I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
> > with my uptime.
> >
> > gentoo root # uptime
> >  22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00
> 
> Doesn't ring any bell yet. Can you cat /proc/uptime and /proc/stat output?
> Is this immediately after booting? Reproducable?

I had this happen yesterday with a 2.5.70-bkWhatever from about three days
ago.

Immediately after boot my uptime was reported as 14664 days, 13 hours.  I 
didn't do a cat of either /proc/uptime or /proc/stat.  If the bug hits 
again, I'll do so and post the results.

-- 
Alex Goddard
agoddard@purdue.edu
