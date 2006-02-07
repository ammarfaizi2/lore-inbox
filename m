Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWBGRKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWBGRKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBGRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:10:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43142 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750971AbWBGRKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:10:34 -0500
Date: Tue, 7 Feb 2006 09:10:18 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602071343.59384.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602070909080.24623@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602071314.34879.ak@suse.de> <20060207123001.GA634@elte.hu>
 <200602071343.59384.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> On Tuesday 07 February 2006 13:30, Ingo Molnar wrote:
> 
> > you are a bit biased towards low-latency NUMA setups i guess (read: 
> > Opterons) :-) 
> 
> Well they are the vast majority of NUMA systems Linux runs on.

The opterons are some strange mix of SMP and NUMA system. The NUMA "nodes" 
are on the same motherboard and therefore there are only small latencies 
involved. NUMA only gives small benefits.
