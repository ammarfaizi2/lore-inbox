Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJYWWj>; Fri, 25 Oct 2002 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSJYWWc>; Fri, 25 Oct 2002 18:22:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38160 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261645AbSJYWTn>;
	Fri, 25 Oct 2002 18:19:43 -0400
Message-ID: <3DB9C4E3.2030905@pobox.com>
Date: Fri, 25 Oct 2002 18:25:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>	<1035584076.13032.96.camel@irongate.swansea.linux.org.uk> 	<E185CbL-0008R5-00@starship> <1035583810.1501.4004.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Fri, 2002-10-25 at 18:06, Daniel Phillips wrote:
>
>  
>
>>On Saturday 26 October 2002 00:14, Alan Cox wrote:
>>
>>    
>>
>>>Im just wondering what we would then use to describe a true multiple cpu
>>>on a die x86. Im curious what the powerpc people think since they have
>>>this kind of stuff - is there a generic terminology they prefer ?
>>>      
>>>
>>MIPS also has it, for N=2.
>>    
>>
>
>Yep, neat chip :)
>
>POWER4 calls the technology "Chip-Multiprocessing (CMP)" but I have
>never seen terminology for referring to the on-core processors
>individually.
>
>They do call the SMT units "threads" obviously, however, so if Alan is
>OK with it maybe we should go with Jun's opinion and name the field
>"thread" ?
>  
>

"thread" already has another use.  Let's not let the idiocy [most 
likely] perpetrated by marketing folks to filter down to the useful 
technical level.  :)

Sorta like Intel and their re-re-use of "IPF."  It's only going to 
increase confusion.

    Jeff





