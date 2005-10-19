Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVJSRZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVJSRZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVJSRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:25:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37109 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751175AbVJSRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:25:30 -0400
Date: Wed, 19 Oct 2005 10:25:33 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.net, akpm@osdl.org,
       tony@atomide.com
Subject: Re: [patch 0/5] RNG cleanup & new drivers attempt #1
Message-ID: <20051019172532.GA13917@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051019081906.615365000@omelas> <43565FB1.50301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43565FB1.50301@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19 2005, at 11:01, Jeff Garzik was caught saying:
> Not interesting in pursuing this path.  This has been discussed 
> endlessly, check the archives.
> 
> We want the FIPS tests.  Hardware (especially cheap hardware) is often 
> known to go haywire.  Trusting hardware to do the FIPS tests is pretty 
> silly, since you're trusting the piece that might go haywire to tell you 
> its OK.  RNGs have a history of suddenly providing non-random data, for 
> a variety of reasons (usually poor board wiring).
> 
> We also want the userspace daemon because that gives the sysadmin far 
> more control over how much entropy is added to the system.  99.9% of the 
> cases in the real world, we don't want the RNG pumping entropy into the 
> pool at full speed.  That will likely pump in more data than a system 
> needs, chewing CPU.  The admin can't even kill the daemon to reclaim his 
> CPU, if its all in-kernel.

OK, understood. But other than the fastpath idea, are you OK with 
the direction I took with the code?

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
