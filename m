Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbULOE67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbULOE67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbULOE67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:58:59 -0500
Received: from mail.suse.de ([195.135.220.2]:47059 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261881AbULOE64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:58:56 -0500
Date: Wed, 15 Dec 2004 05:58:55 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Brent Casavant <bcasavan@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215045855.GH27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <50260000.1103061628@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50260000.1103061628@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And just to clarify, are you saying you want to see this before inclusion
> > in mainline kernels, or that it would be nice to have but not necessary?
> 
> I'd say it's a nice to have, rather than necessary, as long as it's not
> forced upon people. Maybe a config option that's on by default on ia64
> or something. Causing yourself TLB problems is much more acceptable than
> causing it for others ;-)

Given that Brent did lots of benchmarks which didn't show any slowdowns
I don't think this is really needed (at least as long as nobody
demonstrates a ireal slowdown from the patch). And having such special
cases is always ugly, better not have them when not needed.

-Andi
