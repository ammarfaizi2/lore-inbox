Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSJVCqs>; Mon, 21 Oct 2002 22:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJVCqs>; Mon, 21 Oct 2002 22:46:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22534 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261640AbSJVCqq>;
	Mon, 21 Oct 2002 22:46:46 -0400
Message-ID: <3DB4BD8F.1010707@pobox.com>
Date: Mon, 21 Oct 2002 22:53:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com> <200210211642.10435.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Monday 21 October 2002 21:02, Jeff Garzik wrote:
>>>8) Zerocopy NFS (Hirokazu Takahashi)
>>>http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html
>>
>>this is already merged, isn't it??
> 
> 
> Another item straight from Guillaume's list...

You can remove this item...


>>>10) EVMS (Enterprise Volume Management System) (EVMS team)
>>>http://sourceforge.net/projects/evms
>>
>>Sounds like 2.7.x material, viro pointed out several problems ...
> 
> 
> This one's a problem.  LVM1 is dead, so either LVM2 or EVMS are needed to 
> avoid a major functional regression vs 2.4...

A political regression only...  if EVMS is not good enough for inclusion 
in mainline, vendors can merge it and/or LVM2 to avoid problems.  _We_ 
have higher standards for quality :)  If no LVM is ready for 2.6.x, we 
have no LVM.  It's that simple...  If no one has stepped up to clean up 
LVM1, and LVM2 and EVMS are not ready for inclusion, there's not much we 
can do about it.  That's _not_ a reason to merge crap...


>>>14) USAGI IPv6.
>>>
>>>Yoshifuji Hideyaki points out that ipv6 is very important overseas
>>>(where some entire countries make do with a single class B ipv4
>>>
>>>address range).  He says:
>>>
>>>>Well, our IPsec is ready, runs and is tested...
>>>>ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/
>>>
>>The USAGI guys have been slowly splitting up their patches and
>>submitting them... AFAIK DaveM is just waiting on more split-up IPv6
>>patches from them...
> 
> 
> Okay, ARE the Usagi IPV6 patches and Dave's work dovetailing into one project?  
> I'll happily collate them if so, I'd just like to hear it from one of the 
> principal authors...


I'm sure he can elaborate, but AFAIK DaveM and Alexey are only doing 
IPSEC... where USAGI and IPSEC intersect, there will be clashes.  So if 
USAGI is waiting on IPSEC to submit more patches, things are waiting on 
DaveM.  But if there are IPSEC-independent patches, USAGI should go 
ahead and send them :)

	Jeff



