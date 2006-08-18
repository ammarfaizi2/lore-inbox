Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWHRCaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWHRCaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 22:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWHRCaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 22:30:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56250 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932323AbWHRCaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 22:30:11 -0400
Date: Thu, 17 Aug 2006 19:25:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Arnd Bergmann <arnd@arndb.de>,
       David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
In-Reply-To: <20060816142557.acccdfcf.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608171920220.28680@schroedinger.engr.sgi.com>
References: <20060814110359.GA27704@2ka.mipt.ru> <200608152221.22883.arnd@arndb.de>
 <20060816053545.GB22921@2ka.mipt.ru> <20060816084808.GA7366@infradead.org>
 <20060816142557.acccdfcf.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Andi Kleen wrote:

> That's not true on all NUMA systems (that they have a slow interconnect)
> I think on x86-64 I would prefer if it was distributed evenly or maybe even 
> on the CPU who is finally going to process it.
> 
> -Andi "not all NUMA is an Altix"

The Altix NUMA interconnect has the same speed as far as I can recall as 
Hypertransport. It is the distance (real physical cable length) that 
creates latencies for huge systems. Sadly the Hypertransport is designed 
to stay on the motherboard. Hypertransport can only be said to be fast 
because its only used for tinzy winzy systems of a few processors. Are 
you saying that the design limitations of Hypertransport are an 
advantage?


