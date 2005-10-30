Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVJ3T6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJ3T6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVJ3T6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:58:39 -0500
Received: from waste.org ([216.27.176.166]:37001 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932262AbVJ3T6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:58:38 -0500
Date: Sun, 30 Oct 2005 11:53:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to alt urls for local trees
Message-ID: <20051030195312.GT4367@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain> <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain> <1130506546.9574.62.camel@localhost.localdomain> <20051028170030.GA4367@waste.org> <Pine.LNX.4.58.0510281639030.13877@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510281639030.13877@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:46:30PM -0400, Steven Rostedt wrote:
> 
> If you add a 6 element to the version_info tree, it will be used as an
> alternate url.  I tested this a little, and it seems to work.  Might want
> to review it though. I'm still not comfortable with python, and I only did
> some small tests.  Basically I checked to see if it would work if it had
> the 6th element, and if it didn't.  But not much else was done to test.

This was pretty good, but I decided to take it a step further. Now
each tree spec can contain a list of URLs rather than a single URL and
they'll be tried in order.

-- 
Mathematics is the supreme nostalgia of our time.
