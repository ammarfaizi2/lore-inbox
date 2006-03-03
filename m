Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWCCOau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWCCOau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWCCOau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:30:50 -0500
Received: from zaz.kom.auc.dk ([130.225.51.10]:27016 "EHLO zaz.kom.auc.dk")
	by vger.kernel.org with ESMTP id S1750883AbWCCOat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:30:49 -0500
Message-ID: <44085311.4000508@kom.aau.dk>
Date: Fri, 03 Mar 2006 15:30:41 +0100
From: Oumer Teyeb <oumer@kom.aau.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP control block interdependence
References: <44081B7B.5060104@kom.aau.dk> <p73d5h3d4oo.fsf@verdi.suse.de>
In-Reply-To: <p73d5h3d4oo.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Andi!
I checked ant the tcp_no_metrics_save is not available...
and it seems I am in luck, as the admins promised to provide me soon 
with a 2.6.12 server to play with...

Have a nice weekend,
Oumer

I checked, and on my laptop 2.4.28 kernel it is, but on 2.4.25 machines I

Andi Kleen wrote:

>Oumer Teyeb <oumer@kom.aau.dk> writes:
> 
>  
>
>> From these I conclude that there is some TCP congestion control and
>>retransmission parameter caching, that is also time dependant....
>>and I want to disable it completley...
>>    
>>
>
>There is yes.
> 
>  
>
>>So in short do you know how to disable this control block
>>interdepence? 
>>    
>>
>
>echo 1 > /proc/sys/net/ipv4/tcp_no_metrics_save
>
>  
>
>>by the way I am using debian linux distribution and "uname -a" gives me
>>Linux 2.4.25-std #1 SMP Mon Mar 22 10:25:51 CET 2004 i686 unknown
>>    
>>
>
>I don't know if that sysctl was already in 2.4 and it's unclear
>if it makes sense to do any tests on such an old codebase anyways.
>Better use a 2.6 kernel.
>
>-Andi
>  
>

