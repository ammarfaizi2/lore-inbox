Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSJYWg4>; Fri, 25 Oct 2002 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJYWg4>; Fri, 25 Oct 2002 18:36:56 -0400
Received: from fmr05.intel.com ([134.134.136.6]:37089 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261626AbSJYWgy>; Fri, 25 Oct 2002 18:36:54 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>, Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 15:42:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The notion of "SMT (Simultaneous Multi-Threaded)" architecture has been
there for a while (at least 8 years, as far as I know). You would get tons
of info if you search it in Internet. 

Jun

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Friday, October 25, 2002 3:26 PM
To: Robert Love
Cc: Daniel Phillips; Alan Cox; Nakajima, Jun; 'Dave Jones';
'akpm@digeo.com'; 'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com';
'Martin J. Bligh'
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo


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




