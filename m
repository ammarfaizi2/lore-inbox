Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311108AbSCMTlb>; Wed, 13 Mar 2002 14:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311112AbSCMTlV>; Wed, 13 Mar 2002 14:41:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54669 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311108AbSCMTlR>;
	Wed, 13 Mar 2002 14:41:17 -0500
Message-ID: <3C8FAB25.1080706@us.ibm.com>
Date: Wed, 13 Mar 2002 11:40:21 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Jonathan A. Davis'" <davis@jdhouse.org>, walter <walt@nea-fast.com>,
        linux-kernel@vger.kernel.org
Subject: Re: oracle rmap kernel version
In-Reply-To: <794826DE8867D411BAB8009027AE9EB913D03D23@FMSMSX38>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Depends on your hardware configuration and how you stress your system with
> db workload, you should consider some performance patch from the linux
> scalability effort project.
> http://lse.sourceforge.net

In particular, take a look at the rollup patches:
http://sourceforge.net/project/shownotes.php?release_id=77093

This one has been tested pretty well.
http://prdownloads.sourceforge.net/lse/lse01.patch

This could use some more testing, but is not bad by any means:
http://prdownloads.sourceforge.net/lse/lse02.patch

BTW, what SCSI controllers are you planning on using?  Some are better 
than others.

-- 
Dave Hansen
haveblue@us.ibm.com

