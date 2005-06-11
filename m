Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVFKBjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVFKBjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFKBj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:39:26 -0400
Received: from babingka.lava.net ([64.65.64.26]:5840 "EHLO babingka.lava.net")
	by vger.kernel.org with ESMTP id S261510AbVFKBjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:39:18 -0400
Date: Fri, 10 Jun 2005 15:39:15 -1000 (HST)
From: Tim Newsham <newsham@lava.net>
To: linux-kernel@vger.kernel.org
Subject: Source Routing - bug?
Message-ID: <Pine.BSI.4.61.0506101536100.11929@malasada.lava.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  I posted a question about a possible bug to the linux-net
group.  After a small amount of discussion it seems the consensus
is that it is a bug.  I'm posting it here because the discussion
was rather sparse and no solutions have been proposed.

The original question is at:
http://marc.theaimsgroup.com/?l=linux-net&m=111810624427984&w=2

and the thread can be found at:
http://marc.theaimsgroup.com/?t=111810627600005&r=1&w=2

The short of it is that source routing does not appear to be
working properly.  When I try to source route through an
address on the local machine before routing out to other machines
the packets seem to drop into the bit bucket.  I've turned on
forwarding and source routing and tried with rp_filter set
off (as well as on).  Similar tests work fine from BSD (and
when targetted to linux machines).  See the referenced postings
for more details.

Tim Newsham
http://www.lava.net/~newsham/
