Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVCNVoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVCNVoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVCNVop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:44:45 -0500
Received: from waste.org ([216.27.176.166]:57793 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261932AbVCNVnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:43:43 -0500
Date: Mon, 14 Mar 2005 13:43:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Vegard Lima <Vegard.Lima@hia.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pam and nice-rt-prio-rlimits
Message-ID: <20050314214336.GG3163@waste.org>
References: <1110791657.1807.11.camel@pingvin.krs.hia.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110791657.1807.11.camel@pingvin.krs.hia.no>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:14:17AM +0100, Vegard Lima wrote:
> Hello,
> 
> in the long thread on "[request for inclusion] Realtime LSM" there
> doesn't appear to be too many people who has actually tested the
> nice-and-rt-prio-rlimits.patch. Well, it works for me...
> 
> However, the patch to pam_limits posted here:
>   http://lkml.org/lkml/2005/1/14/174
> is a little bit aggressive on the semi-colon side.

It would be more helpful if you pointed out the exact bug. But I think
I spotted the bug in question the first time around.

Please double-check and test this patch from -mm, which will likely
show up in mainline:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/broken-out/nice-and-rt-prio-rlimits.patch

-- 
Mathematics is the supreme nostalgia of our time.
