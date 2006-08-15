Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWHOTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWHOTHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWHOTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:07:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030462AbWHOTG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:06:58 -0400
Message-ID: <44E21B47.7020501@garzik.org>
Date: Tue, 15 Aug 2006 15:06:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
References: <1155172597.3161.72.camel@localhost.localdomain> <44DACB21.9080002@garzik.org> <44DB5FC0.5070405@us.ibm.com> <20060810100012.abc1b5a1.akpm@osdl.org> <20060814214442.GB4032@ucw.cz>
In-Reply-To: <20060814214442.GB4032@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> We do maintain a quilt(akpm) style patches on http://ext2.sf.net, the 
>>> latest patches are always at 
>>> http://ext2.sourceforge.net/48bitext3/patches/latest/
>>>
>>> We thought about doing git initially, still open for that doing do, if 
>>> it's more preferable by Linus or Andrew. Just thought  it's a lot 
>>> easiler for non git user to pull the patches from a project website.
>>>
>> We should aim to get the big copy-ext3-to-ext4 patch into Linus's tree as
>> early as possible.
>>
>> I'm just not sure when to do that.  Immediately after 2.6.19-rc1 is
>> released would be good because it is when every tree (including -mm) is in
>> its most-synced-up state.
> 
> Or you could simply do it _now_. Its new-driver-like, so freeze should
> not apply :-).

I agree... though that is contingent on having _some_ ext4 patches 
reviewed and applied.

	Jeff


