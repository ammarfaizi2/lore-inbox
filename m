Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUFQWks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUFQWks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUFQWks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:40:48 -0400
Received: from main.gmane.org ([80.91.224.249]:7884 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264076AbUFQWk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:40:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gabriel Lavoie <exibis@hotmail.com>
Subject: Re: Toshiba keyboard lockups
Date: Thu, 17 Jun 2004 18:37:27 -0400
Message-ID: <cat6f7$afh$1@sea.gmane.org>
References: <40A162BA.90407@sun.com>            <200405121149.37334.rjwysocki@sisk.pl>            <40C7880C.4000401@sun.com>            <200406101915.i5AJFCBu197611@car.linuxhacker.ru> <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com> <cam9p7$n7c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: modemcable185.89-201-24.mc.videotron.ca
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
In-Reply-To: <cam9p7$n7c$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just reinstalled Gentoo this week and the problem appeared! With 
kernel 2.6.5- I didn't had this problem. I now have it with 2.6.6 and 
2.6.7. I'm using a Toshiba Satellite A20 (Canadian version).

Sean Legassick wrote:
> Jason Munro wrote:
> 
>>> Not sure if I have exact problem like you do, but at least I have
>>> something similar. Once in a while keyboard suddenly stopps working,
>>> touchpad still work though (I have Toshiba Satellite Pro (centrino
>>> based) laptop here). 
> 
> 
> I know that "me toos" are of limited use, but I have also been 
> experiencing this problem. I can give some specific details, and on 
> request am willing to work to produce additional diagnostics / test 
> patches etc.
> 
> I am using a Toshiba Satellite 2410-603 with a P4 M processor, and I 
> have experienced difficulties with Gentoo-patched 2.6.3 sources, 
> Gentoo-patched 2.6.5 sources and vanilla 2.6.6 sources, with 
> CONFIG_PREEMPT both on and off.
> 
> Of the three, 2.6.3 seems the least affected - although I do get 
> occasional keyboard lockups, if I use the mouse for a few seconds the 
> keyboard becomes re-enabled. On both the 2.6.5 and 2.6.6 kernels a 
> keyboard lockup seems permanent, although I haven't tried leaving it for 
> more than a minute or two.
> 
> I too can see warnings from atkbd.c in the kernel messages (on all three 
> kernel versions) reporting 'Unknown key pressed' and 'too many keys 
> pressed'.
> 
> I am well aware that Toshiba keyboards are buggy - under 2.4 kernels I 
> experienced multiple key event problems, so I think what's being asked 
> here on this thread is not that the keyboard driver be "fixed" as such, 
> but that, if possible, it is extended to work around the buggy hardware.
> 
> Thanks,
> 
> Sean
> 

