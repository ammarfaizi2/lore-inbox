Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTF0OY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTF0OY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:24:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:17852 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264363AbTF0OY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:24:56 -0400
Date: Fri, 27 Jun 2003 07:38:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mel Gorman <mel@csn.ul.ie>, Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <23150000.1056724707@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0306271345330.14677@skynet>
References: <200306250111.01498.phillips@arcor.de> <200306262100.40707.phillips@arcor.de><Pine.LNX.4.53.0306262030500.5910@skynet> <200306270222.27727.phillips@arcor.de> <Pine.LNX.4.53.0306271345330.14677@skynet>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> IIRC, Martin J. Bligh had a patch which displayed information about the
> buddy allocator freelist so that will probably be the starting point. From
> there, it should be handy enough to see how intermixed are kernel page
> allocations with user allocations. It might turn out that kernel pages
> tend to be clustered together anyway.

That should be merged now - /proc/buddyinfo. I guess you could do the same
for allocated pages (though it'd be rather heavyweight ;-))

M.

