Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEaAPF>; Thu, 30 May 2002 20:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSEaAPE>; Thu, 30 May 2002 20:15:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312590AbSEaAPC>;
	Thu, 30 May 2002 20:15:02 -0400
Message-ID: <3CF6C009.6040206@mandrakesoft.com>
Date: Thu, 30 May 2002 20:12:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leif Sawyer <lsawyer@gci.com>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] x86 cpu selection (first hack)
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31508EC0CD6@berkeley.gci.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer wrote:

>Dave Jones replied to 
>  
>
>>Jeff Garzik who wrote:
>>
>>    
>>
>>>[I] wonder if making the CPU features selectable is useful? 
>>>i.e. provide an actual config option for MMX memcpy, F00F bug,
>>>WP, etc. Normal (current) logic is to look at the cpu selected,
>>>and deduce these options.
>>>      
>>>
>>J.A's comment that most people compiling kernels shouldn't 
>>need to know what bugs their CPU has before they pick it is
>>a good one imo
>>
>>    
>>
>
>Perhaps a comprimise could be made?
>
>Envision a config option where you would have 'expert' choices
>for MMX, FOOF, WP, etc.
>  
>


Well...  let's rein in the horses.  Before we go too far down this road, 
I would rather that we just get one thing, individual cpu selection, 
correct.  After that, we can look at making processor features 
selectable, or grouping cpus based on "expert" details like lack of WP 
or supporting TSC.

    Jeff




