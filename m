Return-Path: <linux-kernel-owner+w=401wt.eu-S1751982AbXAQDO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbXAQDO2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXAQDO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:14:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58487 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751982AbXAQDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:14:28 -0500
Date: Tue, 16 Jan 2007 19:14:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 1/8] Convert higest_possible_node_id() into nr_node_ids
In-Reply-To: <200701170905.17234.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0701161913180.4677@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116054748.15358.31856.sendpatchset@schroedinger.engr.sgi.com>
 <200701170905.17234.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Andi Kleen wrote:

> On Tuesday 16 January 2007 16:47, Christoph Lameter wrote:
> 
> > I think having the ability to determine the maximum amount of nodes in
> > a system at runtime is useful but then we should name this entry
> > correspondingly and also only calculate the value once on bootup.
> 
> Are you sure this is even possible in general on systems with node
> hotplug? The firmware might not pass a maximum limit.

In that case the node possible map must include all nodes right?

