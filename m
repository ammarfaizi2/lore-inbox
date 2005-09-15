Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVIONXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVIONXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbVIONXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:23:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50311 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030414AbVIONXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:23:11 -0400
Date: Thu, 15 Sep 2005 14:54:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       hugh@veritas.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Hugh's alternate page fault scalability approach on 512p Altix
Message-ID: <20050915125433.GA468@openzaurus.ucw.cz>
References: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2. The use rss and anon_rss deltas instead of atomic incs brings small 
>    performance enhancements in the lower cpu ranges (1-32) but hurt (%50 
>    performance drop at 512 processors) in the high range. The hurting may
>    be due to the percularities of SGIs NUMA router architecture and the 

I'd say that 50% drop at 512 CPUs is acceptable. I did not even
know we support that many CPUs.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

