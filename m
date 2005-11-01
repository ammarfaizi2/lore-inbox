Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVKATG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVKATG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKATG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:06:57 -0500
Received: from [67.137.28.189] ([67.137.28.189]:53122 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751130AbVKATG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:06:57 -0500
Message-ID: <4367A990.2040301@utah-nac.org>
Date: Tue, 01 Nov 2005 10:44:48 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com> <200511012000.21176.mbuesch@freenet.de>
In-Reply-To: <200511012000.21176.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, don't take the code without the suppliers permission.  It contains 
trade secrets and you can get into a ot of trouble if there's an 
agreement between the two of you.  Contact the supplier.  Tell them to 
abstract away thre kernel headers, or rewrite to remove them, or grant 
you persmission to open source the driver.  The UK is the land of 
frivilous lawsuits (I should know a lot about this :-)  ), so don;t 
expose yourself and breach any agreements. 

Jeff


Michael Buesch wrote:

>On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
>  
>
>>Hello.
>>
>>A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
>>driver as source code.  They have provided this code source with a
>>license stating I won't redistribute it in anyway.
>>My concern is that if I build this code into a module, I won't be able
>>to distribute it to customers without violating either the GPL (by not
>>distributing the source code), or the proprietary source code license
>>as currently imposed by the supplier.
>>From what I have read, this concern is only valid if the binary module
>>is considered to be a 'derived work' of the kernel.  The module source
>>directly includes the following kernel headers :
>>    
>>
>
>Take the code and write a specification for the device.
>Should be fairly easy.
>Someone else will pick up the spec and write a clean GPLed driver.
>
>Like these, without the reverse engineering part:
>http://en.wikipedia.org/wiki/Clean_room_design
>http://en.wikipedia.org/wiki/Chinese_wall#Computer_science
>
>  
>

