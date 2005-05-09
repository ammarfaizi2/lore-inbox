Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVEISDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVEISDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEISDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:03:14 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51716 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261468AbVEISDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:03:10 -0400
Message-ID: <427FA5E9.4080409@tmr.com>
Date: Mon, 09 May 2005 14:03:21 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net><20050419121530.GB23282@schottelius.org> <20050506211455.3d2b3f29.akpm@osdl.org>
In-Reply-To: <20050506211455.3d2b3f29.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ricky Beam <jfbeam@bluetronic.net> wrote:
> 
>>Short of a kernel module to export the kernel variables, that's the only
>> damned way to find the number of cpus in a Linux system.
> 
> 
> Question is: do you need to know the number of CPUs (why?) or do you need
> to know the number of CPUs which you're currently allowed to use or do you
> need to know the maximum number of CPUs which you are allowed to bind
> yourself to, or what?

I can see responsible programs checking Ncpu before deciding how many 
threads to start, so it seems that some accurate info could be useful in 
the real world.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
