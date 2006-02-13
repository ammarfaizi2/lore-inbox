Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWBMVWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWBMVWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWBMVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:22:46 -0500
Received: from solarneutrino.net ([66.199.224.43]:54280 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030190AbWBMVWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:22:45 -0500
Date: Mon, 13 Feb 2006 16:22:44 -0500
To: anders@latitude.mynet.no-ip.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060213212243.GE16566@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060213211044.066CE5E401E@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:10:43PM +0100, anders@latitude.mynet.no-ip.org wrote:
> 
> ryan@tau.solarneutrino.net said:
> > Ever since upgrading our file server from 2.6.11.3 to 2.6.14+, it
> > has been experiencing random reboots about every 2-3 weeks.  I'm
> > pretty certain it's a kernel issue: it shares a UPS with a few other
> > machines, so it's not the power.  We had uptimes of ~6 months with
> > 2.6.11.3, and I've run memtest86 overnight since adding some memory
> > a few months ago, so I don't suspect hardware trouble.  We've had 5
> > of these reboots now, so it's a repeatable problem, albeit on an
> > agonizing timescale for testing. 
> 
> Any chance you're running spamassassin on that box? I've seen similar
> issues lately and, comparing /var/log/messages with crontab, have
> concluded that sa-learn sometimes kills the box when run by cron. It
> seems so odd that I haven't found the guts to ask about it figuring
> that I should do some more test myself, but I don't have much else to
> go on...

Nope, no spamassassin.  It doesn't seem to happen at any particular time
of day/week/month or in conjunction with any particular load.

-ryan
