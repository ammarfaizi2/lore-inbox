Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWEGFMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWEGFMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 01:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEGFMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 01:12:50 -0400
Received: from waste.org ([64.81.244.121]:24966 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751028AbWEGFMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 01:12:49 -0400
Date: Sun, 7 May 2006 00:07:49 -0500
From: Matt Mackall <mpm@selenic.com>
To: Theodore Tso <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507050749.GI15445@waste.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org> <20060506203304.GF15445@waste.org> <20060507012200.GC22474@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507012200.GC22474@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 09:22:00PM -0400, Theodore Tso wrote:
> > Again, I think it's perfectly reasonable to sample from all sorts of
> > sources. All my issues are about the entropy accounting.
> 
> But in that case your patch which removes the call to add_entropy() is
> probably not the right thing, yes?

Note the emphatic "again", because I conceded that in my very first
response to you.

The question is, what is the right thing? Not what we have now.

-- 
Mathematics is the supreme nostalgia of our time.
