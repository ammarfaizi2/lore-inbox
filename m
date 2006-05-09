Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWEILYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWEILYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWEILYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:24:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47291 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751761AbWEILYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:24:14 -0400
Date: Tue, 9 May 2006 13:23:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@davemloft.net>, tytso@mit.edu,
       mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060509112334.GB8816@elf.ucw.cz>
References: <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <20060508062604.GD5765@ucw.cz> <20060508.000754.06312852.davem@davemloft.net> <20060508140500.GZ15445@waste.org> <20060508172111.GA5266@ucw.cz> <20060508172726.GH15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508172726.GH15445@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 08-05-06 12:27:26, Matt Mackall wrote:
> On Mon, May 08, 2006 at 05:21:12PM +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > > What do other platforms without a TSC do?
> > > 
> > > Using get_cycles() for /dev/random is new as of 2.6. Before that, we
> > > were directly calling rdtsc on x86 alone. 10msec resolution is fine
> > > for plenty of sources.
> > 
> > For what devices are timestamps still 'random/unobservable' in 10msec
> > range?
> > 
> > Maybe keyboard... but no, keyboard has autorepeat and can be observed
> > remotely with 10msec accuracy in many cases. (telnet to bbs?)
> 
> Please go look at the code.

Ok, so perhaps it got autorepeat right. Still you claimed "plenty" of
usable sources, and keyboard is remotely observable. Please show me
"plenty".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
