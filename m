Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVKAVuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVKAVuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKAVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:50:40 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:62131 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751283AbVKAVuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:50:39 -0500
Message-ID: <4367E383.4090601@tmr.com>
Date: Tue, 01 Nov 2005 16:52:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: JaniD++ <djani22@dynamicweb.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpuset - question
References: <035101c5df17$223eccb0$0400a8c0@dcccs>
In-Reply-To: <035101c5df17$223eccb0$0400a8c0@dcccs>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JaniD++ wrote:
> Hello, list
> 
> I have tried this:
> 
> [root@dy-xeon-1 dev]# mount -t cpuset none /dev/cpuset
> [root@dy-xeon-1 dev]# cd /dev/cpuset
> [root@dy-xeon-1 cpuset]# mkdir cpus_0
> [root@dy-xeon-1 cpuset]# cd cpus_0
> [root@dy-xeon-1 cpus_0]# /bin/echo 0 > cpus
> [root@dy-xeon-1 cpus_0]# /bin/echo 1 > mems
> /bin/echo: write error: Numerical result out of range
> [root@dy-xeon-1 cpus_0]# echo 1 >mems
> [root@dy-xeon-1 cpus_0]# cat mems
> 
> [root@dy-xeon-1 cpus_0]# /bin/echo $$ > tasks
> /bin/echo: write error: No space left on device
> [root@dy-xeon-1 cpus_0]# echo $$ >tasks
> [root@dy-xeon-1 cpus_0]# cat tasks
> [root@dy-xeon-1 cpus_0]#
> 
> The google, and man pages cant help.
> What can i do?

Start by telling us what kernel and patches you run, what config option 
you used, etc. Oh, and what you're trying to do...
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
