Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVIMW2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVIMW2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVIMW2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:28:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932544AbVIMW2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:28:33 -0400
Date: Tue, 13 Sep 2005 15:28:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Stewart <andystewart@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.13 BUG tg3.c:2805 = crash (this one isn't tainted)
Message-ID: <20050913222830.GG7991@shell0.pdx.osdl.net>
References: <43263CDC.1010604@comcast.net> <43264C1C.9030207@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43264C1C.9030207@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Stewart (andystewart@comcast.net) wrote:
> I think I have an idea of what I can do to cause this to occur:
> 
> 1) Run setiathome(boinc) so both CPUs are at 100% (nice) utilization
> 2) Run rsync to sync a few GB between machines on a 100 Mb ethernet network
> 3) Notice puzzlingly slow interactive response time with high (8-10)
> load average.
> 4) Click the mouse a bunch of times here, there, everywhere in
> frustration with 3(above)
> 5) I caused the crash within about 5 minutes.  I may be able to
> reproduce it - not sure.

Might help to copy netdev on the report.  Seems you've had a bit of luck
in reproducing.  Any chance on narrowing down to last known good kernel?
There's been a fair bit of change in that driver between 2.6.12 and
2.6.13.

thanks,
-chris
