Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJPSCa>; Wed, 16 Oct 2002 14:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJPSCa>; Wed, 16 Oct 2002 14:02:30 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:8749
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261327AbSJPSB0>; Wed, 16 Oct 2002 14:01:26 -0400
Message-ID: <3DADAC6D.8080407@rackable.com>
Date: Wed, 16 Oct 2002 11:14:05 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 18:07:23.0313 (UTC) FILETIME=[E0680210:01C2753E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Wed, 16 Oct 2002, Samuel Flory wrote:
>
>  
>
>>>On Wed, 16 Oct 2002, Mark Cuss wrote:
>>>
>>> 
>>>
>>>
>>>This is the correct behavior. If you don't like this, you can
>>>swap motherboards with me ;) Otherwise, grin and bear it!
>>>
>>> 
>>>
>>>      
>>>
>> 
>>  Wouldn't it be easier just to turn off the hypertreading or jackson 
>>tech option in the bios ;-)
>>
>>    
>>
>
>Why would you ever want to turn it off?  You paid for a CPU with
>two execution units and you want to disable one?  This makes
>no sense unless you are using Windows/2000/Professional, which
>will trash your disks and all their files if you have two
>or more CPUs (true).
>
>  
>

  Actually I can think of 3 obvious reasons:

1)Your app is cache bound, and not cpu bound.
2)Your system tends to only run 1 or 2 non thread activities at a time.
3)You don't trust hyperthreading.


