Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUIXVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUIXVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIXVV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:21:59 -0400
Received: from scorsese.fabricadeideias.com.br ([200.157.56.34]:48269 "EHLO
	scorsese.fabricadeideias.com") by vger.kernel.org with ESMTP
	id S268899AbUIXVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:21:47 -0400
Message-ID: <41548FFE.60803@fabricadeideias.com>
Date: Fri, 24 Sep 2004 18:21:44 -0300
From: Rodrigo Severo <rodrigo.lists@fabricadeideias.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: SCSI Initio 9100UW (INIC-950p chipset) support nunder kernel
 2.6.x
References: <4151A24A.7000302@fabricadeideias.com> <20040922170651.A3340@infradead.org> <20040922201424.GC2098@unicorn.sch.bme.hu>
In-Reply-To: <20040922201424.GC2098@unicorn.sch.bme.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:

>On Wed, Sep 22, 2004 at 05:06:51PM +0100, Christoph Hellwig wrote:
>  
>
>>On Wed, Sep 22, 2004 at 01:03:00PM -0300, Rodrigo Severo wrote:
>>    
>>
>>>with kernel 2.4.24 (yes, I know it's old).
>>>
>>>I want to update my kernel do 2.6.8. The question: is there support for 
>>>this board/chipset under kernel 2.6.x?
>>>
>>>I looked around a lot and couldn't find much. www.initio.com says their 
>>>code is in the kernel since 2.0.32. Has it been left out for 2.6.x?
>>>
>>>Is anyone working on this port? Anyone intending to work on it?
>>>      
>>>
>>The driver still exists and actually compiles.  It's marked BROKEN, although
>>I don't know why.  If you want to help testing we can update it to current
>>standards.
>>    
>>
>
>It works perfectly for me. (I have 1 disk and 1 cdrom.)
>
>Also note that mandrake ships a kernel with the BROKEN flag patched off.
>
>I do not know why was it marked as such.
>
In fact it works just fine for me too. As Christoph Hellwig latest 
message suggested I was suffering lack-of-st-driver sickness *:">

As far as I can tell the driver is really fine. Maybe it's time to 
remove the BROKEN flag from it? I am not sure who is responsible for 
this but here is my Works For Me vote.


Thanks you all for your help,

Rodrigo Severo

*
