Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULWPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULWPgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULWPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:36:38 -0500
Received: from bender.bawue.de ([193.7.176.20]:23516 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261259AbULWPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:36:32 -0500
Date: Thu, 23 Dec 2004 16:36:24 +0100
From: Joerg Sommrey <jo175@sommrey.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041223153624.GA5349@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Nathan Scott <nathans@sgi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041221185754.GA28356@sommrey.de> <20041222182606.GA14733@infradead.org> <20041222195203.GA24857@sommrey.de> <20041223101143.A702917@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041223101143.A702917@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 10:11:43AM +1100, Nathan Scott wrote:
> Certainly wasn't XFS using stack in the initial oops, perhaps
> the lower layers, but I'm a bit sceptical.  Almost certainly
> this is a device mapper snapshot problem, the DM folks should
> be able to analyse it further.
In the last couple of weeks I had a couple of other dm snapshot related
problems too.  Even last night the system hung after creating snapshots. 
So this really seems to be the source of my troubles.

-jo

-- 
-rw-r--r--  1 jo users 63 2004-12-23 16:25 /home/jo/.signature
