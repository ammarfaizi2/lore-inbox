Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWALCq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWALCq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWALCq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:46:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:51894 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964994AbWALCqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:46:25 -0500
Subject: Re: [PATCH 6/10] NTP: add time_adjust to tick_nsec
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220024290.30918@scrub.home>
References: <Pine.LNX.4.61.0512220024290.30918@scrub.home>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:46:23 -0800
Message-Id: <1137033983.2890.111.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:25 +0100, Roman Zippel wrote:
> This removes time_adjust from update_wall_time_one_tick() and moves it
> to second_overflow() and adds it to tick_nsec_curr instead.
> This slightly changes the adjtime() behaviour, instead of applying it to
> the next tick, it's applied to the next second. As this interface isn't
> used by ntp, there shouldn't be much users left.
> 

This sounds reasonable to me. 
Although CC'ing Ulrich and George for more review.


Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john


