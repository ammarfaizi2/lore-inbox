Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTLKFdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLKFdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:33:42 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:43982 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264331AbTLKFdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:33:40 -0500
Message-ID: <3FD801B3.7080604@wmich.edu>
Date: Thu, 11 Dec 2003 00:33:39 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au>
In-Reply-To: <3FD7FCF5.7030109@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought highmem wasn't necesarily needed for memory <=2GB? Highmem 
incurs some performance hits doesn't it and so the urge to move to it 
with only 2GB is not very attractive.  Anyways i'm just interested in if 
that's the case or not since 2GB is easy to get to these days and i had 
heard that highmem could be avoided passed the 1GB barrier.



Nick Piggin wrote:
> 
> 
> Donald Maner wrote:
> 
>> The kernel you're using WAS compiled with CONFIG_HIGHMEM4G=y, correct?
>>
>> -----Original Message-----
>> From: Raul Miller [mailto:moth@magenta.com] Sent: Wednesday, December 
>> 10, 2003 10:52 PM
>> To: linux-kernel@vger.kernel.org
>> Subject: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB
>> ram.
>>
>>
>> [1.] Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
>>
> 
> Raul Miller wrote:
> 
>>
>> [7.2.] /proc/cpuinfo says:
>>
>> processor       : 0
>> vendor_id       : AuthenticAMD
>> cpu family      : 15
>> model           : 5
>> model name      : AMD Opteron(tm) Processor 240
>>
> 
> Or ARCH=x86_64 ?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


