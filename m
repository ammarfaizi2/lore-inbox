Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCUTRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCUTRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCUTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:17:09 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:62105 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261666AbVCUTOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:14:16 -0500
Message-ID: <423F1A6B.5040005@utah-nac.org>
Date: Mon, 21 Mar 2005 12:03:07 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clone() and pthread_create() segment fault in 2.4.29
References: <423F13EA.6050007@utah-nac.org> <1111431021.6952.73.camel@laptopd505.fenrus.org> <423F1852.3070902@utah-nac.org> <20050321190721.GA19194@devserv.devel.redhat.com>
In-Reply-To: <20050321190721.GA19194@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Mon, Mar 21, 2005 at 11:54:10AM -0700, jmerkey wrote:
>  
>
>>Arjan van de Ven wrote:
>>
>>    
>>
>>>On Mon, 2005-03-21 at 11:35 -0700, jmerkey wrote:
>>>
>>>
>>>      
>>>
>>>>In case nobody has already reported it, clone() and pthread_create() 
>>>>return SIGSEGV faults
>>>>when a 2.4.29 kernel on the Taroon Red Hat release.
>>>>  
>>>>
>>>>        
>>>>
>>>you're running an OS that requires a kernel with NPTL support. Yet you
>>>run a kernel without. Bad idea.
>>>
>>>
>>>
>>>
>>>      
>>>
>>which 2.4 kernels will work properly on RH ES release 3, Taroon Update 
>>4. 
>>    
>>
>
>Only kernels with NPTL in, which for 2.4 limits you to the RH supplied one.
>
>  
>
Thanks for the update on this issue.

Jeff
