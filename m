Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTIHOUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTIHOUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:20:32 -0400
Received: from jalapeno.cc.columbia.edu ([128.59.59.238]:1533 "EHLO
	jalapeno.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S262373AbTIHOUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:20:31 -0400
Message-ID: <3F5C9010.1080607@cs.columbia.edu>
Date: Mon, 08 Sep 2003 10:20:00 -0400
From: Haoqiang Zheng <hzheng@cs.columbia.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <3F4182FD.3040900@cyberone.com.au>	 <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>	 <20030820021351.GE4306@holomorphy.com> <3F4A1386.9090505@cs.columbia.edu>	 <3F4A172F.8080303@cyberone.com.au> <3F4A272F.8000602@cs.columbia.edu>	 <20030902142552.GG1358@openzaurus.ucw.cz> <1063028436.21084.30.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063028436.21084.30.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-No-Spam-Score: Local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you define "priority inversion" if the app is remote?

Alan Cox wrote:

>On Maw, 2003-09-02 at 15:25, Pavel Machek wrote:
>  
>
>>>in the best position to decide which process is more important. 
>>>That's why I proposed kernel based approach.
>>>      
>>>
>>Tasks can easily report their interactivity needs/nice value.
>>X are already depend on clients not trying to screw each other,
>>so thats okay.
>>    
>>
>
>There is a slight problem with a kernel based approach too - the app may
>be remote. 
>
>Alan
>  
>


