Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJOEUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJOEUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 00:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVJOEUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 00:20:09 -0400
Received: from mail.tmr.com ([64.65.253.246]:46248 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751071AbVJOEUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 00:20:07 -0400
Message-ID: <43508485.5040800@tmr.com>
Date: Sat, 15 Oct 2005 00:24:37 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
References: <200510071111.46788.andrew@walrond.org>
In-Reply-To: <200510071111.46788.andrew@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:

>I need to deploy some very resilient servers with hot swapable drives.
>
>I always used dac960 based hardware raid for hot swapping in the past, but 
>sata drives are so cheap compared to scsi that I'm considering the Tyan GT24 
>server with 4 hot swappable SATA II drives (nforce4 pro controller)
>
>	http://www.tyan.com/products/html/gt24b2891.html
>
>Before I place an order, I need to know whether sata II hot swapping is up to 
>scratch in the linux kernel, and whether it works nicely with linux software 
>raid (which I already use/am familiar with).
>
>Any knowledge greatfully accepted :)
>

As others have noted, SATA is young and should not be used for hot-swap, 
at least in a production manner. I suggest the IBM ServeRAID controller 
as one solution for SCSI. I have a bunch of servers in various places 
around the country, and these have been good to me, work pretty well 
with typical failures, and IBM supports them.

I've deployed about 35 of these and am still happy, so you have a data 
point. Most of my servers have 3-6TB.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

