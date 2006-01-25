Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWAYUrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWAYUrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAYUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:47:16 -0500
Received: from ns1.siteground.net ([207.218.208.2]:14006 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751204AbWAYUrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:47:16 -0500
Date: Wed, 25 Jan 2006 12:47:13 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, pravin shelar <pravins@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Message-ID: <20060125204713.GA3658@localhost.localdomain>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <43D50445.1080208@cosmosbay.com> <43D50880.605@cosmosbay.com> <200601251431.16513.ak@suse.de> <20060125195946.GC3573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125195946.GC3573@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 11:59:46AM -0800, Ravikiran G Thirumalai wrote:
> 
> How about doing the above using a debug config option? So that when the
> config option is turned on, all per-cpu area references to not possible 
> cpus crash? and leave that option default on on -mm :).  That way we can 
> quickly catch all references.  We can probably change the arch independent 
> setup_per_cpu_areas also to do allocations for cpu_possible cpus only while 
> we are at it?

Ahh! just realised mm3 is already out with the Eric Dumazet's patch.

