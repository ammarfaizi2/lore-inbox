Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWAUSqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWAUSqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWAUSqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:46:39 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:17156 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932240AbWAUSqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:46:38 -0500
Message-ID: <43D28189.3080407@argo.co.il>
Date: Sat, 21 Jan 2006 20:46:33 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
References: <200601212108.41269.a1426z@gawab.com>
In-Reply-To: <200601212108.41269.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2006 18:46:37.0118 (UTC) FILETIME=[0231E5E0:01C61EBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>A long time ago, when i was a kid, I had dream. It went like this:
>
>I am waking up in the twenty-first century and start my computer.
>After completing the boot sequence, I start top to find that my memory is 
>equal to total disk-capacity.  What's more, there is no more swap.
>Apps are executed inplace, as if already loaded.
>Physical RAM is used to cache slower storage RAM, much the same as the CPU 
>cache RAM caches slower physical RAM.
>
>  
>
I'm sure you can find a 4GB disk on ebay.

>When I woke up, I was really looking forward for the new century.
>
>Sadly, the current way of dealing with memory can at best only be described 
>as schizophrenic.  Again the reason being, that we are still running in the 
>last-century mode.
>
>Wouldn't it be nice to take advantage of todays 64bit archs and TB drives, 
>and run a more modern way of life w/o this memory/storage split personality?
>  
>
Perhaps you'd be interested in single-level store architectures, where 
no distinction is made between memory and storage. IBM uses it in one 
(or maybe more) of their systems. A particularly interesting example is 
http://www.eros-os.org.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

