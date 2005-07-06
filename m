Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVGFFyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVGFFyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVGFFxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:53:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41431 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261464AbVGFEVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:21:43 -0400
Date: Wed, 6 Jul 2005 10:00:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050706043056.GA4223@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050701075600.GC4625@in.ibm.com> <20050701142555.GB31989@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701142555.GB31989@kvack.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 10:25:55AM -0400, Benjamin LaHaise wrote:
> On Fri, Jul 01, 2005 at 01:26:00PM +0530, Suparna Bhattacharya wrote:
> > On one test system I see a degradation from around 17+ MB/s to 11MB/s
> > for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> > to 2.6.12. It doesn't seem filesystem specific. Not good :(
> 
> What sort of io subsystem does it have?  Also, does changing the 

aic7xxx.
> elevator make any difference?  I'm away for the long weekend, but will 

I tried switching to the noop elevator - the regression was still there.

> help look into this next week.

Do you see the regression as well, or is it just me ?

Regards
Suparna

> 
> 		-ben

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

