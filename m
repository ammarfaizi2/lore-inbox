Return-Path: <linux-kernel-owner+w=401wt.eu-S932488AbWLNK4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWLNK4c (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWLNK4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:56:32 -0500
Received: from il.qumranet.com ([62.219.232.206]:43711 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488AbWLNK4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:56:31 -0500
Message-ID: <45812DDD.4080907@argo.co.il>
Date: Thu, 14 Dec 2006 12:56:29 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: arjan@infradead.org
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il>	 <1166091570.27217.983.camel@laptopd505.fenrus.org>	 <45812B83.90006@argo.co.il> <1166093641.27217.989.camel@laptopd505.fenrus.org>
In-Reply-To: <1166093641.27217.989.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-12-14 at 12:46 +0200, Avi Kivity wrote:
>   
>> Arjan van de Ven wrote:
>>     
>>>> I understand one still has to write a kernel driver to shut up the irq.  
>>>> How about writing a small bytecode interpreter to make event than 
>>>> unnecessary?
>>>>     
>>>>         
>>> if you do that why not do a real driver.
>>>
>>>   
>>>       
>> An entire driver in bytecode? 
>>     
>
> no a real, non-bytecode driver.
>
>   

Isn't the whole point of uio is to avoid writing a kernel mode driver?

As proposed, it doesn't quite accomplish it.  With an additional 
bytecode interpreter, you can have a 100% userspace driver (the bytecode 
interpreter would be part of uio, not the driver).


-- 
error compiling committee.c: too many arguments to function

