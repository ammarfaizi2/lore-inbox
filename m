Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWEAWI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWEAWI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEAWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:08:56 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:53959 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S932297AbWEAWIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:08:55 -0400
Message-ID: <445686F0.3080402@dunaweb.hu>
Date: Tue, 02 May 2006 00:08:48 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Bad page state in process 'nfsd' with xfs
References: <4454D59C.7000501@dunaweb.hu> <20060501102440.A1864834@wobbly.melbourne.sgi.com> <4455C1D0.5060104@dunaweb.hu> <20060502073325.B1873249@wobbly.melbourne.sgi.com>
In-Reply-To: <20060502073325.B1873249@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nathan Scott írta:
> On Mon, May 01, 2006 at 10:07:44AM +0200, Zoltan Boszormenyi wrote:
>   
>> Hi,
>>
>> Nathan Scott írta:
>>     
>>> On Sun, Apr 30, 2006 at 05:19:56PM +0200, Zoltan Boszormenyi wrote:
>>>   
>>>       
>>>> ...
>>>> Or not. I had an FC3/x86-64 system until two days ago, now I have FC5/86-64.
>>>>
>>>> When FC3 was installed I chose to format the partitions to XFS and since 
>>>> then
>>>> I had Oopses regularly with or without VMWare modules.
>>>>     
>>>>         
>>> What was the stack trace for your oops...?
>>>
>>> cheers.
>>>   
>>>       
>> I reported some Oopses for earlier kernels, they are here:
>>     
>
> These aren't oopses.  They do look similar, but slightly
> different to the other report - your page count there is
> off with the pixies, but its not as clear that its a single
> bit error - yours are more like 0xfffe0000.  Quite strange.
> You also have the odd high-32-bits-mirrors-low-32-bits in
> page flags, both with one bit set.
>
> Not sure XFS can be causing this (we don't touch page count
> for regular file pages, and only touch PageUptodate in flags
> IIRC, like most/all filesystems).
>
> Were you also using NFS, as in the other report?
>
> cheers.
>
>   

No, it's just a standalone machine.

Best regards,
Zoltán Böszörményi

