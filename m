Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSFTRKg>; Thu, 20 Jun 2002 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSFTRKf>; Thu, 20 Jun 2002 13:10:35 -0400
Received: from holomorphy.com ([66.224.33.161]:17855 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315430AbSFTRKe>;
	Thu, 20 Jun 2002 13:10:34 -0400
Date: Thu, 20 Jun 2002 10:10:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sandy Harris <pashley@storm.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
Message-ID: <20020620171006.GV22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sandy Harris <pashley@storm.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020619222444.A26194@work.bitmover.com> <3D11F7B9.27C74922@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D11F7B9.27C74922@storm.ca>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 11:41:45AM -0400, Sandy Harris wrote:
> For large multi-processor systems, it isn't clear that those matter
> much. On single user systems I've tried , ps -ax | wc -l usually
> gives some number 50 < n < 100. For a multi-user general purpose
> system, my guess would be something under 50 system processes plus
> 50 per user. So for a dozen to 20 users on a departmental server,
> under 1000. A server for a big application, like database or web,
> would have fewer users and more threads, but still only a few 100
> or at most, say 2000.

Certain unnameable databases like to have 2K processes at minimum and
see task counts soar even higher under significant loads.

Also, the scholastic departmental servers I've seen in action generally
host 300+ users with something less than 50/logged in user and something
more than 50 for the baseline. For the school-wide one I used hosting
10K+ (40K+?) users generally only between 500 and 2500 (where the non-rare
maximum was around 1500) are logged in simultaneously, and the task/user
count was more like 5-10, with a number of them (most?) riding at 2 or 3
(shell + MUA or shell + 2 tasks for rlogin to elsewhere). The uncertainty
with respect to number of accounts is due to no userlists being visible.

I can try to contact some of the users or administrators if better
numbers are needed, though it may not work as I've long since graduated.

Cheers,
Bill
