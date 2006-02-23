Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWBWVb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWBWVb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBWVbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:31:55 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:62916 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932082AbWBWVbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:31:55 -0500
Message-ID: <43FE29C8.1000606@bootc.net>
Date: Thu, 23 Feb 2006 21:31:52 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jurriaan <thunder7@xs4all.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MD Raid 6: poor algorithm choice?
References: <43FDF82A.5050201@bootc.net> <20060223210915.GA2800@amd64.of.nowhere>
In-Reply-To: <20060223210915.GA2800@amd64.of.nowhere>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:
> From: Chris Boot <bootc@bootc.net>
> Date: Thu, Feb 23, 2006 at 06:00:10PM +0000
>   
>> Hi all,
>>
>> [4295106.474000] raid6: mmxx2     2500 MB/s
>> [4295106.521000] raid6: sse1x2    2339 MB/s
>> [4295106.524000] raid6: using algorithm sse1x2 (2339 MB/s)
>> [4295106.531000] md: raid6 personality registered for level 6
>>
>> I just loaded the raid6 module for fun (might end up using it one day), and 
>> I was surprised at its choice of algorithm. By the messages above, I would 
>> have assumed it would choose the mmxx2 algorithm at 2500 MB/s instead of 
>> sse1x2 at the slightly slower 2339 MB/s. This is probably entirely expected 
>> behaviour, but why?
>>
>>     
> Because it is more cache-efficient (allows the other code to run at a
> higher speed). This comes up now and again, perhaps these messages
> should be rephrased.
>   
I knew there would be a good reason for this, I just couldn't figure it 
out from those messages. That's a very good explanation indeed, and as 
you say, perhaps the messages should be updated.

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
