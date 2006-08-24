Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWHXF0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWHXF0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 01:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWHXF0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 01:26:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:43977 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030296AbWHXF0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 01:26:45 -0400
Message-ID: <44ED3851.7040202@zytor.com>
Date: Wed, 23 Aug 2006 22:25:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Re: Linux: Why software RAID?
References: <44ED1E41.40606@garzik.org> <44ED3723.3090308@nortel.com>
In-Reply-To: <44ED3723.3090308@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Jeff Garzik wrote:
> 
>> But anyway, to help answer the question of hardware vs. software RAID, 
>> I wrote up a page:
>>
>>     http://linux.yyz.us/why-software-raid.html
> 
> Just curious...with these guys 
> (http://www.bigfootnetworks.com/KillerOverview.aspx) putting linux on a 
> PCI NIC to allow them to bypass Windows' network stack, has anyone ever 
> considered doing "hardware" raid by using an embedded cpu running linux 
> software RAID, with battery-backed memory?
> 
> It would theoretically allow you to remain feature-compatible by 
> downloading new kernels to your RAID card.
> 

Yes.  In fact, I have been told by several RAID chip vendors that their 
customers are *strongly* demanding that their chips be able to run Linux 
  md (and still use whatever hardware offload features.)

So it's happening.

	-hpa
