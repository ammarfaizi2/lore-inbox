Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbUCJIVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUCJIVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:21:23 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:31372 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262094AbUCJIVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:21:22 -0500
Message-ID: <404ECFE5.7040005@matchmail.com>
Date: Wed, 10 Mar 2004 00:20:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org>
In-Reply-To: <20040303193025.68a16dc4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
>>Most of the previous 2.6 kernels I was running on these servers would be 
>>lightly hitting swap by now.  This definitely looks better to me.
> 
> 
> It sounds worse to me.  "Lightly hitting swap" is good.  It gets rid of stuff,
> freeing up physical memory.

Andrew, it looks like you're right.  This[1] server doesn't seem to be 
hitting swap enough.  But my other[2] file server is doing great with it 
on the other hand (though, it hasn't swapped at all).

Maybe a little tuning is in order?

Any patches I should try?

Mike

[1]
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html

[2]
http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-memory.html
