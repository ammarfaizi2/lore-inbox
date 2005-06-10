Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVFJGiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVFJGiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 02:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVFJGiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 02:38:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47503 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262414AbVFJGh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 02:37:58 -0400
Date: Fri, 10 Jun 2005 08:38:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
Message-ID: <20050610063858.GN5140@suse.de>
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com> <87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca> <873brs5ir8.fsf@stark.xeocode.com> <42A85F5E.10208@rtr.ca> <87u0k74cuy.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0k74cuy.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09 2005, Greg Stark wrote:
> 
> Mark Lord <liml@rtr.ca> writes:
> 
> > Greg Stark wrote:
> > ..
> > >>You should be using "-y" (standby) instead of "-Y" (sleep).
> > > I'll try that. But that's not going to make it spin up when it gets a SMART
> > > query is it?
> > 
> > Depends on what SMART items are being queried.
> > 
> > Actually, what you should *really* be using is "hdparm -S"
> > with a suitable timeout value (say, 30 or larger).
> 
> Not really since the drive will just spin up ever few seconds as bdflush (or
> whatever it's called these days) dribbles out pages.
> 
> What I should *really* be using is the noflushd daemon. That's been on hold
> since I found it didn't work with SATA drives. But I wonder if it would work
> these days.

noflushd is ancient, have you tried playing with laptop mode?

-- 
Jens Axboe

