Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTFCLHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTFCLHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:07:37 -0400
Received: from unsol-intbg.internet-bg.net ([212.124.67.226]:34577 "HELO
	ns.unixsol.org") by vger.kernel.org with SMTP id S264955AbTFCLHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:07:36 -0400
Message-ID: <3EDC849E.1080907@unixsol.org>
Date: Tue, 03 Jun 2003 14:21:02 +0300
From: Peter Petrov <peter@unixsol.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: bg, en-us, en
MIME-Version: 1.0
To: Andrey Nekrasov <andy@spylog.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug report (linux-2.4.20-suse12 +e1000 +xeon +ht)
References: <20030603104158.GA21071@an.spylog.com>
In-Reply-To: <20030603104158.GA21071@an.spylog.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Nekrasov wrote:
> Hello.
> 
>  help me please :)
> 
> 1. Problem:
> 
>   The big load (~30Mbit/sec real traffic + iptables with connection tracking) results to
>   that the server does not respond some time. 
> 
>   And kernel write message:
> 
> ...
> Jun  3 07:46:22 router1 kernel: Neighbour table overflow.                                                                

Increase values in  /proc/sys/net/ipv4/neigh/default/gc_thresh*

> Jun  3 07:46:22 router1 last message repeated 9 times                                                                    
> Jun  3 07:49:59 router1 kernel:                                                                                          
> Jun  3 07:49:59 router1 kernel: wait_on_irq, CPU 3:                                                                      

See module's parameters of eth1000. Exact *IntDelay


-- 
Regards,
Peter Petrov
peter@unixsol.org

