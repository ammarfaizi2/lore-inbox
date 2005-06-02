Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFBUKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFBUKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFBUJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:09:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4538 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261262AbVFBTst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:48:49 -0400
Message-ID: <429F631E.6020401@engr.sgi.com>
Date: Thu, 02 Jun 2005 14:50:54 -0500
From: Ray Bryant <raybry@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jschopp@austin.ibm.com
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Mel Gorman <mel@csn.ul.ie>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay> <429E50B8.1060405@yahoo.com.au> <429F2B26.9070509@austin.ibm.com>
In-Reply-To: <429F2B26.9070509@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In summary here are the reasons I see to run with Mel's patch:
> 
> 1. It really helps with medium-large allocations under memory pressure.
> 2. Page migration defrag will need it.
> 3. Memory hotplug remove will need it.
> 

Could someone point me at the "Page migration defrag" patch, or
describe what this is.  Does this depend on the page migration
patches from memory hotplug to move pages or is it something
different?

Thanks,
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
