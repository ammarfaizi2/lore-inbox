Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289899AbSAKIof>; Fri, 11 Jan 2002 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289901AbSAKIoV>; Fri, 11 Jan 2002 03:44:21 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:12036 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289899AbSAKIoK>; Fri, 11 Jan 2002 03:44:10 -0500
Message-ID: <3C3EA5D8.7050206@redhat.com>
Date: Fri, 11 Jan 2002 03:44:08 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, tom@infosys.tuwien.ac.at,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <3C3DEAFA.4070102@redhat.com> <200201110742.g0B7gDa16387@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

> On Thursday 10 January 2002 21:26, Doug Ledford wrote:
> 
>>Alan Cox wrote:
>>
>>>Make sure you test with both apic and non apic Doug. The previous hangs I
>>>fixed up were specific to APIC mode because the APIC means the irq
>>>arrival is later and more asynchronous
>>>
>>I can't.  APIC makes my test machine (my only i810 machine) hang on boot
>>
> 
> I have both 'Local APIC support on uniprocessors' and
> 'IO_APIC support on uniprocessors' enabled in kernel configuration.
> Should I try i810_audio.c v0.19 after disabling APIC support in
> kernel (v2.4.17)?
> 
> Andris
> 
> 
> 

No, just try the 0.20 version that I have up in the normal place.  It should 
solve your problem.

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

