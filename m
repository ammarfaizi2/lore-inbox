Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283432AbRLMFvk>; Thu, 13 Dec 2001 00:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLMFva>; Thu, 13 Dec 2001 00:51:30 -0500
Received: from neuron.com ([209.61.186.37]:49415 "EHLO server1.neuron.com")
	by vger.kernel.org with ESMTP id <S283432AbRLMFvZ>;
	Thu, 13 Dec 2001 00:51:25 -0500
Message-ID: <3C1841BB.8010003@neuron.com>
Date: Thu, 13 Dec 2001 00:50:51 -0500
From: Stewart Allen <stewart@neuron.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: passing params to boot readonly
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in a bit of a pickle and need to find a way to pass boot params to a 
reiserfs rootfs to *prevent* it from replaying the journal on single-user 
boot. This may seem like a strange request, but I've got a degraded RAID array 
that I need to poke around in before deciding whether or not to send a disk 
off to a rehab lab. If the replay occurs, it will potentially destroy the fs 
since I'm using a degraded snapshot of the failed disk in hopes of reclaiming 
*some* of my data. The system is running 2.2.x (can't remember and can't find 
out w/out booting).

Do I have a snowball's chance of pulling this off?

thanks,

stewart

