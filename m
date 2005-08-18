Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVHRQPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVHRQPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVHRQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:15:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15514 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932279AbVHRQPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:15:07 -0400
Date: Thu, 18 Aug 2005 21:52:50 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@linux.intel.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [AIO] aio-2.6.13-rc6-B1
Message-ID: <20050818162250.GA9928@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050817184406.GA24961@linux.intel.com> <20050818100259.GA7060@in.ibm.com> <20050817231649.GA25997@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817231649.GA25997@linux.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 07:16:49PM -0400, Benjamin LaHaise wrote:
> On Thu, Aug 18, 2005 at 03:32:59PM +0530, Suparna Bhattacharya wrote:
> > Using IPI Shortcut mode
> > VFS: Cannot open root device "sda6" or unknown-block(8,6)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,6)
> 
> Are you sure the scsi driver is configured in?  This doesn't look related 
> to any of the changes in the patch.  I'm going to be away from email for 
> the next week, so you'll have to figure this out.

You are right, it does look like a different problem - happens even without
the patchset, just with vanilla 2.6.13-rc6. I'll refresh my build and try
again to see if it is a real problem..

Regards
Suparna

> 
> 		-ben
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

