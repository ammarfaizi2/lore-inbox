Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUIQS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUIQS4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIQS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:56:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5075 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268944AbUIQS4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:56:11 -0400
Message-ID: <414B3270.2080409@sgi.com>
Date: Fri, 17 Sep 2004 13:52:32 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] lockmeter: fixes
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com> <20040917083127.F10537@infradead.org>
In-Reply-To: <20040917083127.F10537@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Sep 16, 2004 at 04:03:44PM -0700, Ray Bryant wrote:
> 
>>Andrew,
>>
>>The first patch in this series is a replacement patch for the prempt-fix
>>patch I sent earlier this morning.  There was a missing paren in that
>>previous version.
> 
> 
> Any chance you could stop lockmeter patching around in fs/proc/proc_misc.c?
> procfs files can be created easily from individual drivers.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hi Christoph,

Yes, I'll take a look at it as soon as I get done chasing the COOL bits changes.

Is there a specific example you can point me at as to how others have done this?

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

