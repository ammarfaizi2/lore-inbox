Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWAQJuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWAQJuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAQJuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:50:13 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:54440 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751345AbWAQJuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:50:12 -0500
Date: Tue, 17 Jan 2006 10:50:20 +0100
From: Sander <sander@humilis.net>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060117095019.GA27262@localhost.localdomain>
Reply-To: sander@humilis.net
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CCA80B.4020603@tls.msk.ru>
X-Uptime: 10:26:31 up 61 days, 25 min, 10 users,  load average: 2.57, 2.20, 1.86
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote (ao):
> NeilBrown wrote:
> > Greetings.
> > 
> > In line with the principle of "release early", following are 5
> > patches against md in 2.6.latest which implement reshaping of a
> > raid5 array. By this I mean adding 1 or more drives to the array and
> > then re-laying out all of the data.
> 
> Neil, is this online resizing/reshaping really needed? I understand
> all those words means alot for marketing persons - zero downtime,
> online resizing etc, but it is much safer and easier to do that stuff
> 'offline', on an inactive array, like raidreconf does - safer, easier,
> faster, and one have more possibilities for more complex changes. It
> isn't like you want to add/remove drives to/from your arrays every
> day... Alot of good hw raid cards are unable to perform such reshaping
> too.

I like the feature. Not only marketing prefers zero downtime you know :-)

Actually, I don't understand why you bother at all. One writes the
feature. Another uses it. How would this feature harm you?

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
