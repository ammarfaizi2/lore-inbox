Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUCDD6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCDD6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:58:06 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:24237 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261330AbUCDD6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:58:02 -0500
Message-ID: <4046A93D.9090305@matchmail.com>
Date: Wed, 03 Mar 2004 19:57:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org>
In-Reply-To: <20040303193025.68a16dc4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
>>>
>>>- More VM tweaks and tuneups
>>
>>Running 2.6.3-lofft-snsus-264rc1mm2vm (nfsd loff_t, sunrpc locking & -mm 
>>VM patches).  Seems to be working well.
> 
> 
> OK, good.
> 
> 
>>Most of the previous 2.6 kernels I was running on these servers would be 
>>lightly hitting swap by now.  This definitely looks better to me.
> 
> 
> It sounds worse to me.  "Lightly hitting swap" is good.  It gets rid of stuff,
> freeing up physical memory.

Swapping out is good to me.  It's the swapping in, and out, and in, 
and... that's bad.

> 
> But I do not see a lot of difference here.

Let's let it run a few more days to make sure.

> The 900MB desktop machine is
> 300M into swap after 24 hours.  That's usual.

Neither of my servers have 900MB ram...

Mike
