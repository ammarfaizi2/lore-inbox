Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbUKCUVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUKCUVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUKCUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:21:34 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23681 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261864AbUKCUUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:20:51 -0500
Message-ID: <41893E4E.3090602@tmr.com>
Date: Wed, 03 Nov 2004 15:23:42 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB CD/disk not working after 2.6.7
References: <4189137A.2090408@tmr.com><4189137A.2090408@tmr.com> <20041103183425.GB13063@m.safari.iki.fi>
In-Reply-To: <20041103183425.GB13063@m.safari.iki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Wed, Nov 03, 2004 at 12:20:58PM -0500, Bill Davidsen wrote:
> 
>>Since 2.6.7 no kernel has seen my USB CD burner or disk. I took the disk 
>>off to simplify the picture, it still doesn't work.
> 
> ...
> 
>>Buffer I/O error on device uba, logical block 0
>> unable to read partition table
> 
> 
> remove this line from .config and rebuild kernel...
> CONFIG_BLK_DEV_UB=y
> 
> ...and it will just work.
> 
Thank you for the prompt answer! I've started rebuilding the kernel.

Do you know if  the incompatibility between flash key support and 
CD/disk a bug, design decision, or unavoidable characteristic of the 
devices involved? I have some kind of a flash key coming for evaluation, 
so I built with that on.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
