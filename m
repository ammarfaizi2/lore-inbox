Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUBCH6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 02:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUBCH6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 02:58:55 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:34522 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265910AbUBCH6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 02:58:02 -0500
Message-ID: <401F5467.50702@cyberone.com.au>
Date: Tue, 03 Feb 2004 18:57:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       philip@codematters.co.uk
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87smhsy7n4.wl@canopus.ns.zel.ru>	<20040202230745.237dd5b6.akpm@osdl.org> <87r7xcy4zy.wl@canopus.ns.zel.ru>
In-Reply-To: <87r7xcy4zy.wl@canopus.ns.zel.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samium Gromoff wrote:

>At Mon, 2 Feb 2004 23:07:45 -0800,
>Andrew Morton wrote:
>  
>
>>Samium Gromoff <deepfire@sic-elvis.zel.ru> wrote:
>>    
>>
>>>      
>>>
>>>>>The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and                   
>>>>> ReiserFS.  It's a few years old and has always run Linux, most                      
>>>>> recently 2.4.24.  I decided to try 2.6.1 and the performance is                     
>>>>> disappointing.                                                                      
>>>>>          
>>>>>
>>>>                                                                                       
>>>>2.6 has a few performance problems under heavy pageout at present.  Nick               
>>>>Piggin has some patches which largely fix it up.                                       
>>>>        
>>>>
>>>I`m sorry, but this is misguiding. 2.6 does not have a few performance
>>>problems under heavy pageout.
>>>
>>>      
>>>
>>As you have frequently and somewhat redundantly reminded us.
>>    
>>
>
>Right. I`m rather emotional about this...
>
>Kind of hard seeing the all starry and shiny 2.6 going down the toilet on my
>little server with 16M RAM.
>
>  
>
>>Perhaps you could test Nick's patches.   They are at
>>
>>	http://www.kerneltrap.org/~npiggin/vm/
>>
>>Against 2.6.2-rc2-mm2.  First revert vm-rss-limit-enforcement.patch, then
>>apply those three.
>>    
>>
>
>Hmmm, i`d prefer plain 2.6, but i`ll try it anyway.
>
>  
>

It should go against plain 2.6 with luck.

