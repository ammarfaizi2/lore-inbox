Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWFWPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWFWPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFWPW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:22:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17384 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751455AbWFWPW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:22:26 -0400
Subject: Re: [PATCH 12/15] dm: add exports
From: Arjan van de Ven <arjan@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060623150011.GW19222@agk.surrey.redhat.com>
References: <20060621193657.GA4521@agk.surrey.redhat.com>
	 <20060621210504.b1f387bd.akpm@osdl.org>
	 <20060622135117.GS19222@agk.surrey.redhat.com>
	 <20060622100353.50a7654e.akpm@osdl.org>
	 <20060623150011.GW19222@agk.surrey.redhat.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 17:22:21 +0200
Message-Id: <1151076141.3204.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 16:00 +0100, Alasdair G Kergon wrote:
> On Thu, Jun 22, 2006 at 10:03:53AM -0700, Andrew Morton wrote:
> > Adding twenty new unused exports is rather a big deal.  Do you have some
> > new code pending which will use all these?
> 
> No - there's code on the horizon which wants to use a few and so I did this
> clean-up exercise to indicate which ones should be used and which ones
> shouldn't.  It's no problem delaying the actual exports until they're
> specifically requested, but I would at least like to move the definitions
> into include/linux so people know they are welcome to use them if they wish.

the thing is, exports make the kernel bigger (over 100Kb or so total on
just the unused ones), so avoiding unneeded ones as much as possible
would be a good thing.

