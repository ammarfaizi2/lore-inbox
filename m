Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWFWPd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWFWPd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFWPd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:33:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751463AbWFWPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:33:26 -0400
Date: Fri, 23 Jun 2006 16:33:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-ID: <20060623153323.GA4848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060621193657.GA4521@agk.surrey.redhat.com> <20060621210504.b1f387bd.akpm@osdl.org> <20060622135117.GS19222@agk.surrey.redhat.com> <20060622100353.50a7654e.akpm@osdl.org> <20060623150011.GW19222@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623150011.GW19222@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 04:00:11PM +0100, Alasdair G Kergon wrote:
> On Thu, Jun 22, 2006 at 10:03:53AM -0700, Andrew Morton wrote:
> > Adding twenty new unused exports is rather a big deal.  Do you have some
> > new code pending which will use all these?
> 
> No - there's code on the horizon which wants to use a few and so I did this
> clean-up exercise to indicate which ones should be used and which ones
> shouldn't.  It's no problem delaying the actual exports until they're
> specifically requested, but I would at least like to move the definitions
> into include/linux so people know they are welcome to use them if they wish.

Please dont introduce exports eaarly.  I'm also very curious about what kind
of user you have in the pipeline, calling these functions from kernelspace
seems very wrong to me.

