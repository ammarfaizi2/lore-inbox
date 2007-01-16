Return-Path: <linux-kernel-owner+w=401wt.eu-S1750977AbXAQB6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXAQB6g (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 20:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbXAQB6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 20:58:36 -0500
Received: from ns.suse.de ([195.135.220.2]:48776 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbXAQB6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 20:58:35 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 1/8] Convert higest_possible_node_id() into nr_node_ids
Date: Wed, 17 Jan 2007 09:05:16 +1100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com> <20070116054748.15358.31856.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054748.15358.31856.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170905.17234.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 16:47, Christoph Lameter wrote:

> I think having the ability to determine the maximum amount of nodes in
> a system at runtime is useful but then we should name this entry
> correspondingly and also only calculate the value once on bootup.

Are you sure this is even possible in general on systems with node
hotplug? The firmware might not pass a maximum limit.

At least CPU hotplug definitely has this issue and I don't see nodes
to be very different.

-Andi
>
