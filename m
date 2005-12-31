Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWAAC7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAAC7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 21:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWAAC7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 21:59:07 -0500
Received: from hera.kernel.org ([140.211.167.34]:2721 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932182AbWAAC6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 21:58:45 -0500
Date: Sat, 31 Dec 2005 20:19:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
Subject: Re: [PATCH 01/14] page-replace-single-batch-insert.patch
Message-ID: <20051231221916.GB4024@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224002.765.28812.sendpatchset@twins.localnet> <20051231070320.GA9997@dmt.cnet> <Pine.LNX.4.63.0512310943450.27198@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512310943450.27198@cuia.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 09:44:07AM -0500, Rik van Riel wrote:
> On Sat, 31 Dec 2005, Marcelo Tosatti wrote:
> 
> > Unification of active and inactive per cpu page lists is a requirement 
> > for CLOCK-Pro, right?
> 
> You can approximate the functionality through use of scan
> rates.  Not quite as accurate as a unified clock, though.

Rik, I dont understand what you mean.

My point is that the page-replacement-policy abstraction patches affect
the original behaviour, and they shouldnt. See the post from Peter about
abstracting the per-cpu lists.

We're talking about different things.

