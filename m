Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUHJAWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUHJAWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHJAWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:22:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61913 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266751AbUHJAWC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:22:02 -0400
Message-ID: <411813F0.9020602@us.ibm.com>
Date: Mon, 09 Aug 2004 17:16:48 -0700
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2:  Debug: sleeping function called from invalid
 context at mm/mempool.c:197
References: <B179AE41C1147041AA1121F44614F0B0DD03A6@AVEXCH02.qlogic.org>
In-Reply-To: <B179AE41C1147041AA1121F44614F0B0DD03A6@AVEXCH02.qlogic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Vasquez wrote:

>On Monday, August 09, 2004 6:42 AM, linux-kernel-owner@vger.kernel.org
>wrote: 
>  
>
>>I see the msg below while running on 2.6.8-rc3-mm2, but not
>>on the plain
>>rc3 tree;
>>ditto for rc1-mm1 vs rc1, which is as far back as I've gone so far.
>>
>>    
>>
>
>This allocation should be done with GFP_ATOMIC flags.  The attached 
>patch should apply cleanly to any recent kernel
>
>  
>

and seems to work fine.

Thanks,
-Janet

