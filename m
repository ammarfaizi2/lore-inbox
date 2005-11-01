Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVKAVwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVKAVwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVKAVwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:52:14 -0500
Received: from [67.137.28.189] ([67.137.28.189]:55426 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751316AbVKAVwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:52:13 -0500
Message-ID: <4367D04B.80906@utah-nac.org>
Date: Tue, 01 Nov 2005 13:30:03 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Michael Buesch <mbuesch@freenet.de>, alex@alexfisher.me.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>	 <200511012000.21176.mbuesch@freenet.de> <1130875080.22089.14.camel@mindpipe>
In-Reply-To: <1130875080.22089.14.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2005-11-01 at 20:00 +0100, Michael Buesch wrote:
>  
>
>>On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
>>    
>>
>>>Hello.
>>>
>>>A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
>>>driver as source code.  They have provided this code source with a
>>>license stating I won't redistribute it in anyway.
>>>My concern is that if I build this code into a module, I won't be able
>>>to distribute it to customers without violating either the GPL (by not
>>>distributing the source code), or the proprietary source code license
>>>as currently imposed by the supplier.
>>>From what I have read, this concern is only valid if the binary module
>>>is considered to be a 'derived work' of the kernel.  The module source
>>>directly includes the following kernel headers :
>>>      
>>>
>>Take the code and write a specification for the device.
>>Should be fairly easy.
>>Someone else will pick up the spec and write a clean GPLed driver.
>>    
>>
>
>Seems excessive, why not just use a kernel debugger to capture all PIO
>traffic to the device and write a driver based on that?
>
>Lee
>
>  
>
That's legal, and good advice.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

