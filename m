Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWEHRdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWEHRdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWEHRdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:33:24 -0400
Received: from waste.org ([64.81.244.121]:30938 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932501AbWEHRdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:33:23 -0400
Date: Mon, 8 May 2006 12:27:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "David S. Miller" <davem@davemloft.net>, tytso@mit.edu,
       mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508172726.GH15445@waste.org>
References: <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <20060508062604.GD5765@ucw.cz> <20060508.000754.06312852.davem@davemloft.net> <20060508140500.GZ15445@waste.org> <20060508172111.GA5266@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508172111.GA5266@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 05:21:12PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > What do other platforms without a TSC do?
> > 
> > Using get_cycles() for /dev/random is new as of 2.6. Before that, we
> > were directly calling rdtsc on x86 alone. 10msec resolution is fine
> > for plenty of sources.
> 
> For what devices are timestamps still 'random/unobservable' in 10msec
> range?
> 
> Maybe keyboard... but no, keyboard has autorepeat and can be observed
> remotely with 10msec accuracy in many cases. (telnet to bbs?)

Please go look at the code.

-- 
Mathematics is the supreme nostalgia of our time.
