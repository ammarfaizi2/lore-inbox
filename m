Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUDFBPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUDFBPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:15:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40068 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261358AbUDFBPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:15:02 -0400
Date: Tue, 6 Apr 2004 06:45:08 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406011508.GA5077@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071F9C5.2030002@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:28:53AM +1000, Nick Piggin wrote:
> First of all, if you're proposing this stuff for inclusion, you
> should port it to the -mm tree, because I don't think Andrew
> will want any other scheduler work going in just now. It wouldn't
> be too hard.

Will send out today a patch against latest -mm tree!

> I think my stuff is a bit orthogonal to what you're attempting.
> And they should probably work well together. My "lazy migrate"
> patch means the tasklist lock does not need to be held at all,
> only the dying runqueue's lock.

Is there some place where I can download your patch (or is it in -mm tree)?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
