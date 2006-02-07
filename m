Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWBGRaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWBGRaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWBGRaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:30:08 -0500
Received: from ns1.suse.de ([195.135.220.2]:18355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751033AbWBGRaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:30:06 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 18:28:48 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071343.59384.ak@suse.de> <Pine.LNX.4.62.0602070909080.24623@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070909080.24623@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071828.49370.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:10, Christoph Lameter wrote:
> On Tue, 7 Feb 2006, Andi Kleen wrote:
> 
> > On Tuesday 07 February 2006 13:30, Ingo Molnar wrote:
> > 
> > > you are a bit biased towards low-latency NUMA setups i guess (read: 
> > > Opterons) :-) 
> > 
> > Well they are the vast majority of NUMA systems Linux runs on.
> 
> The opterons are some strange mix of SMP and NUMA system. The NUMA "nodes" 
> are on the same motherboard 

Actually it's not true - 8 socket systems are built out of two
boards. And there are much bigger systems upcomming.

> and therefore there are only small latencies  
> involved. NUMA only gives small benefits.

That's also not true. Everytime I get memory placement for 
process memory wrong users complain _very_ loudly and there 
are clear benefits in benchmarks too.
 
-Andi
