Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWFWPBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWFWPBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWFWPBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:01:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751098AbWFWPBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:01:04 -0400
Date: Fri, 23 Jun 2006 16:00:11 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-ID: <20060623150011.GW19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060621193657.GA4521@agk.surrey.redhat.com> <20060621210504.b1f387bd.akpm@osdl.org> <20060622135117.GS19222@agk.surrey.redhat.com> <20060622100353.50a7654e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622100353.50a7654e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:03:53AM -0700, Andrew Morton wrote:
> Adding twenty new unused exports is rather a big deal.  Do you have some
> new code pending which will use all these?

No - there's code on the horizon which wants to use a few and so I did this
clean-up exercise to indicate which ones should be used and which ones
shouldn't.  It's no problem delaying the actual exports until they're
specifically requested, but I would at least like to move the definitions
into include/linux so people know they are welcome to use them if they wish.

Alasdair
-- 
agk@redhat.com
