Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUI3OU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUI3OU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUI3OU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:20:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21160 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269295AbUI3OUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:20:49 -0400
Message-ID: <415C1643.8000605@watson.ibm.com>
Date: Thu, 30 Sep 2004 10:20:51 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/1] Per-priority statistics for CFQ w/iopriorities 2.6.8.1
References: <20040930065917.GA2288@suse.de>
In-Reply-To: <20040930065917.GA2288@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> Missed this patch the first time over (thank you lwn :-) - why are you
> using atomic counters? In all the paths you set them, you already have
> the queue lock.
> 

Thats right, there's no need for them. I used these instinctively....
Will fix in next version, unless (hint, hint) you're taking a look at 
adding priorities back to mainline's CFQ.

-- Shailabh
