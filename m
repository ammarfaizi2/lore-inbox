Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTLVQhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 11:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLVQhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 11:37:24 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:58380 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264434AbTLVQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 11:37:23 -0500
Subject: Re: Oops with 2.4.23
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031219235521.GK6438@matchmail.com>
References: <20031219224402.GA1284@scrappy>
	 <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
	 <20031219235521.GK6438@matchmail.com>
Content-Type: text/plain
Message-Id: <1072111047.7005.2.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 11:37:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 18:55, Mike Fedyk wrote:
> On Sat, Dec 20, 2003 at 12:35:24AM +0100, Maciej Zenczykowski wrote:
> > > So i have just tested to run memtest86 on my box and i have had no error
> > > with this. I have also tested cpuburn without any result. Have you some
> > > others ideas ?
> > 
> > you did run memtest for a minimum dozen hours? sometimes it takes that 
> > long to find errors...
> 
> Has anyone noticed if several runs with the normal tests, or a single test
> with all tests running catches more errors?

I just did all this last weekend, and the basic operation I use is:
 - two passes at standard mode (this bombed for me at first, so adjust
timings/etc and repeat)
 - two passes at enhanced mode (this bombed on me once, so timings again
and restart from the beginning)
 - and (I skipped this) one pass at 'all' mode, just to be sure

Once it passes 2 standard and 2 enhanced, its a safe bet that it's
clean..

-- 
Disconnect <lkml@sigkill.net>

