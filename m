Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTIZOWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTIZOWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:22:00 -0400
Received: from www.wotug.org ([194.106.52.201]:32318 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S262273AbTIZOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:21:58 -0400
Date: Fri, 26 Sep 2003 15:21:56 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@gatemaster.ivimey.org
To: Maciej Zenczykowski <maze@cela.pl>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0309261521190.22241-100000@gatemaster.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.1 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003, Maciej Zenczykowski wrote:

>> if this syscall activity is so low then it might be much more flexible to
>> control the binary via ptrace and reject all but the desired syscalls.  
>> This will cause a context switch but if it's stdio only then it's not a
>> big issue. Plus this would work on any existing Linux kernel.
>
>Unfortunately sometimes the data transfer through stdio can be counted in 
>hundreds of MB (or even in extreme cases a couple of GB), plus it is 

Would running the process under user-mode linux help any? (I'm not sure)

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

