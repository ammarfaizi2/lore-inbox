Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVGYTgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGYTgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYTgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:36:37 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54031 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261484AbVGYTfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:35:20 -0400
Message-ID: <42E53FF1.5060503@tmr.com>
Date: Mon, 25 Jul 2005 15:39:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@dodo.com.au
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: IDE Zip drive doesn't work under 2.6.12
References: <Pine.GSO.4.58.0507211045180.28914@denali.ccs.neu.edu> <jf73e1db6h1b23o7p2qj7nlijujdh7md0i@4ax.com>
In-Reply-To: <jf73e1db6h1b23o7p2qj7nlijujdh7md0i@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Thu, 21 Jul 2005 11:21:05 -0400 (EDT), Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> 
>>Recently I upgraded from 2.6.11.11 to 2.6.12.3.  This morning I tried
>>using my Zip drive... unfortunately it doesn't work under 2.6.12.3.  To
>>verify that this was a kernel problem, I rebooted to 2.6.11.11.  Here's
>>some relevant output using 2.6.11.11:
> 
> 
> I too see this issue, but it doesn't go away on 2.6.11.12 for me, 
> something is eating /dev/ nodes, writing to them, this doesn't 
> happen in 2.4, so yet another "don't do that", or user-space, I 
> haven't the foggiest.
> 
> fdisk sees the drive on 2.6, 2.4 sees it okay on same hardware

I haven't tried on the most recent kernels, but ZIP seemed to work 
nicely with ide-scsi in earlier 2.6. You might want to try that as a 
data point if nothing else.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
