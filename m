Return-Path: <linux-kernel-owner+w=401wt.eu-S1752009AbXAQEQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXAQEQ2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXAQEQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:16:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbXAQEQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:16:27 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 1/8] Convert higest_possible_node_id() into nr_node_ids
Date: Wed, 17 Jan 2007 15:15:19 +1100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com> <200701170905.17234.ak@suse.de> <Pine.LNX.4.64.0701161913180.4677@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701161913180.4677@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701171515.20380.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 January 2007 14:14, Christoph Lameter wrote:
> On Wed, 17 Jan 2007, Andi Kleen wrote:
> > On Tuesday 16 January 2007 16:47, Christoph Lameter wrote:
> > > I think having the ability to determine the maximum amount of nodes in
> > > a system at runtime is useful but then we should name this entry
> > > correspondingly and also only calculate the value once on bootup.
> >
> > Are you sure this is even possible in general on systems with node
> > hotplug? The firmware might not pass a maximum limit.
>
> In that case the node possible map must include all nodes right?

Yes.

-Andi

