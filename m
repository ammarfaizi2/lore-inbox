Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVADSRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVADSRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVADSRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:17:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34461 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261756AbVADSQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:16:55 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
In-Reply-To: <20050103140359.GA19976@infradead.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 13:16:54 -0500
Message-Id: <1104862614.8255.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 14:03 +0000, Christoph Hellwig wrote:
> On Wed, Dec 29, 2004 at 09:43:22PM -0500, Lee Revell wrote:
> > The realtime LSM has been previously explained on this list.  Its
> > function is to allow selected nonroot users to run RT tasks.  The most
> > common application is low latency audio with JACK, http://jackit.sf.net.
> > 
> > Several people have reported that 2.6.10 is the best kernel yet for
> > audio latency, see
> > http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-December/007341.html.    If the realtime LSM were merged, then this would be the last step to making low latency audio work well with the stock kernel.
> > 
> > We (the authors and the Linux audio community) would like to request its
> > inclusion in the next -mm release, with the eventual goal of having it
> > in mainline.
> > 
> > This is identical to the last version Jack O'Quin posted (but didn't cc:
> > Andrew, or make clear that we would like this added to -mm), so I
> > preserved his Signed-Off-By.
> 
> This is far too specialized.  And option to the capability LSM to grant 
> capabilities to certain uids/gids sounds like the better choise - and
> would also allow to get rid of the magic hugetlb uid horrors.
> 

Got a patch?  Code talks, BS walks.  This is working perfectly, right
now, and is being used by thousands of Linux ausio users.

Lee  

