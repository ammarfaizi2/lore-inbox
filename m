Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUB0KJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUB0KJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:09:38 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:45185 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261782AbUB0KHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:07:33 -0500
Message-ID: <403F16E2.2040706@cyberone.com.au>
Date: Fri, 27 Feb 2004 21:07:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sonika Sachdeva <sonikam@magnum.barc.ernet.in>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler Implementation details
References: <403F0B66.A7920233@magnum.barc.ernet.in> <403F0CD7.5080305@cyberone.com.au> <403F1204.32683547@magnum.barc.ernet.in>
In-Reply-To: <403F1204.32683547@magnum.barc.ernet.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sonika Sachdeva wrote:

>Hi,
>
>I want to give the loaded system metrics(loadavg, io details etc) as the input to
>the simulator program so that it is able to calculate the priority for any new job
>that will be submitted.
>
>Then knowing the execution time of that job in a no-load system, I am able to
>compute the latency encountered becoz of the load on the system.
>
>How can I reuse the sched.c code to do this?
>
>

You can use it to tell your simulator how the Linux kernel will
schedule tasks. I'm not sure exactly what you want, execution time?
latency?

