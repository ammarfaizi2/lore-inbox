Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268044AbTGIBN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 21:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbTGIBN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 21:13:27 -0400
Received: from holomorphy.com ([66.224.33.161]:55207 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S268044AbTGIBNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 21:13:24 -0400
Date: Tue, 8 Jul 2003 18:29:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030709012921.GJ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 12:45:52AM +0200, Ingo Molnar wrote:
> The patch is orthogonal to wli's pgcl patch - both patches try to achieve
> the same, with different methods. I can very well imagine workloads where
> we want to have the combination of the two patches.

Well, your patch does have the advantage of not being a "break all
drivers" affair.

Also, even though pgcl scales "perfectly" wrt. highmem (nm the code
being a train wreck), the raw capacity increase is needed. There are
enough other reasons to go through with ABI-preserving page clustering
that they're not really in competition with each other.

Looks good to me. I'll spin it up tonight.


-- wli
