Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVACOEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVACOEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVACOEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:04:06 -0500
Received: from [213.146.154.40] ([213.146.154.40]:62183 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261453AbVACOEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:04:01 -0500
Date: Mon, 3 Jan 2005 14:03:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050103140359.GA19976@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Jack O'Quin <joq@io.com>
References: <1104374603.9732.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104374603.9732.32.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 09:43:22PM -0500, Lee Revell wrote:
> The realtime LSM has been previously explained on this list.  Its
> function is to allow selected nonroot users to run RT tasks.  The most
> common application is low latency audio with JACK, http://jackit.sf.net.
> 
> Several people have reported that 2.6.10 is the best kernel yet for
> audio latency, see
> http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-December/007341.html.    If the realtime LSM were merged, then this would be the last step to making low latency audio work well with the stock kernel.
> 
> We (the authors and the Linux audio community) would like to request its
> inclusion in the next -mm release, with the eventual goal of having it
> in mainline.
> 
> This is identical to the last version Jack O'Quin posted (but didn't cc:
> Andrew, or make clear that we would like this added to -mm), so I
> preserved his Signed-Off-By.

This is far too specialized.  And option to the capability LSM to grant 
capabilities to certain uids/gids sounds like the better choise - and
would also allow to get rid of the magic hugetlb uid horrors.

