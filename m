Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263358AbVGAOYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbVGAOYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGAOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:24:32 -0400
Received: from kanga.kvack.org ([66.96.29.28]:2478 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S263358AbVGAOY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:24:29 -0400
Date: Fri, 1 Jul 2005 10:25:55 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050701142555.GB31989@kvack.org>
References: <20050701075600.GC4625@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701075600.GC4625@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 01:26:00PM +0530, Suparna Bhattacharya wrote:
> On one test system I see a degradation from around 17+ MB/s to 11MB/s
> for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> to 2.6.12. It doesn't seem filesystem specific. Not good :(

What sort of io subsystem does it have?  Also, does changing the 
elevator make any difference?  I'm away for the long weekend, but will 
help look into this next week.

		-ben
