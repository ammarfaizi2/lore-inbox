Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWBGRmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWBGRmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBGRma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:42:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21130 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932205AbWBGRma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:42:30 -0500
Date: Tue, 7 Feb 2006 09:42:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602071828.49370.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602070941040.24841@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602071343.59384.ak@suse.de> <Pine.LNX.4.62.0602070909080.24623@schroedinger.engr.sgi.com>
 <200602071828.49370.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> > The opterons are some strange mix of SMP and NUMA system. The NUMA "nodes" 
> > are on the same motherboard 
> 
> Actually it's not true - 8 socket systems are built out of two
> boards. And there are much bigger systems upcomming.

But they are still next to one another.... No distance to cover,.
> 
> > and therefore there are only small latencies  
> > involved. NUMA only gives small benefits.
> 
> That's also not true. Everytime I get memory placement for 
> process memory wrong users complain _very_ loudly and there 
> are clear benefits in benchmarks too.

What are the latencies in an 8 way opteron system? I.e. Local memory, next 
processor, most distant processor?


