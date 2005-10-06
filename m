Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVJFSAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVJFSAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVJFSAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:00:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:19939 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751257AbVJFSAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:00:00 -0400
Date: Thu, 6 Oct 2005 19:59:56 +0200
From: Andi Kleen <ak@suse.de>
To: Harald Welte <laforge@netfilter.org>, Andi Kleen <ak@suse.de>,
       Patrick McHardy <kaber@trash.net>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20051006175956.GI6642@verdi.suse.de>
References: <432EF0C5.5090908@cosmosbay.com> <200509281037.03185.ak@suse.de> <4342B575.9090709@trash.net> <200510051853.32196.ak@suse.de> <20051007023801.GA5953@rama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007023801.GA5953@rama>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 04:38:02AM +0200, Harald Welte wrote:
> On Wed, Oct 05, 2005 at 06:53:31PM +0200, Andi Kleen wrote:
> > On Tuesday 04 October 2005 19:01, Patrick McHardy wrote:
> > > Andi Kleen wrote:
> > > > In a sense it's even getting worse: For example us losing the CONFIG
> > > > option to disable local conntrack (Patrick has disabled it some time ago
> > > > without even a comment why he did it) has a really bad impact in some
> > > > cases.
> > >
> > > It was necessary to correctly handle locally generated ICMP errors.
> > 
> > Well you most likely wrecked local performance then when it's enabled.
> 
> so you would favour a system that incorrectly deals with ICMP errors but
> has higher performance?

I would favour a system where development doesn't lose sight of performance.
Perhaps there would be other ways to fix this problem without impacting
performance unduly? Can you describe it in detail? 

-Andi
