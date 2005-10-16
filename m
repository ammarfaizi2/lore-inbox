Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVJPSDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVJPSDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVJPSDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 14:03:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:34697 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751347AbVJPSDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 14:03:37 -0400
Date: Sun, 16 Oct 2005 19:03:27 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/8] Fragmentation Avoidance V17
In-Reply-To: <20051016105346.01c79929.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0510161902370.9492@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
 <20051015195213.44e0dabb.pj@sgi.com> <Pine.LNX.4.58.0510161255570.32005@skynet>
 <20051016105346.01c79929.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2005, Paul Jackson wrote:

> Mel wrote:
> > I would be happy with __GFP_USERRCLM but __GFP_EASYRCLM may be more
> > obvious?
>
> I would be delighted with either one.  Yes, __GFP_EASYRCLM is more obvious.
>

__GFP_EASYRCLM it is then unless someone has an objection. For
consistency, RCLM_USER will change to RCLM_EASY as well. Changing one and
not the other makes no sense to me.

>

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
