Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWD1RDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWD1RDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWD1RCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:02:45 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:41225 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030456AbWD1RCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:02:10 -0400
Message-ID: <44524A8A.3060308@argo.co.il>
Date: Fri, 28 Apr 2006 20:02:02 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Martin Mares <mj@ucw.cz>, Davi Arnaut <davi.lkml@gmail.com>,
       Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>,
       dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua> <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com> <4451E185.9030107@argo.co.il> <mj+md-20060428.105455.7620.atrey@ucw.cz> <4451FCCC.4010006@argo.co.il> <Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 17:02:08.0341 (UTC) FILETIME=[7BC83050:01C66AE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> The high level language allows you to concentrate on the algorithms which is
>> where the performance comes from.
>>     
> Do you consider e.g. Perl or Python highlevel?
>   

I once wrote Perl. I deeply regret the experience. But yes, they are 
both high(er) level. There are even higher levels to aspire to.

> If so: I doubt that's where performance can come from. Ever. (Unless you 
> cheat by using XS.)
>   

Given infinite time, patience, and concentration, the C or C++ program 
will always win over Python; as assembly will win over C or C++.

If your time is bounded, your Python code might be running while you're 
still typing in your C code, you're be profiling and making changes to 
the alghorithm in Python while hunting for that mysterious segmentation 
fault in C (thank goodness for valgrind), and adding multithreading to 
the third and final version of your Python code while debating whether 
to buy more memory or sit down and chase that memory leak.

Developer performance equates to runtime performance.

ps. Yes, that wouldn't work for a simple example like counting words in 
a file. Try something more complex, like an SCM system.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

