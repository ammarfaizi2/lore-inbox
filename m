Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277966AbRJOBzG>; Sun, 14 Oct 2001 21:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277968AbRJOBy4>; Sun, 14 Oct 2001 21:54:56 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:41427 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S277966AbRJOByt>; Sun, 14 Oct 2001 21:54:49 -0400
In-Reply-To: <fa.k3c2fuv.1q26ra4@ifi.uio.no>
            <fa.idkv82v.3jcuip@ifi.uio.no>
In-Reply-To: <fa.idkv82v.3jcuip@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Recursive deadlock on die_lock
Date: Mon, 15 Oct 2001 01:55:20 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BCA4208.000047A1@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes: 

> On 14 Oct 2001 17:14:24 -0600, 
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>Keith Owens <kaos@ocs.com.au> writes:
>>> IA64 also has PAL code which is
>>> called directly by the kernel, that PAL code has no unwind data so
>>> failures in PAL code result in bad or incomplete back traces.
>>
>>PAL Ahh!!!!! 
>>
>>Please tell me that we are not rely on the firmware to be correct
>>after we have finished initializing the operating system. 
>>
>>Please tell me it ain't so.  I have nightmares about that kind of setup.
> 
> Not only do we rely on it, it is mandated by the IA64 design.  Intel
> IA64 System Abstraction Layer, 24535901.pdf.  The IA64 kernel calls SAL
> all over the place.  grep -ir '\<[ps]al' include/asm-ia64/ arch/ia64/

Oh, goody!  What an excellent way to shove CPRM or SSSCA down your throat! 
The possibilities are endless... 

-- 
Sam 

