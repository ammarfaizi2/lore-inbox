Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271547AbTGQST3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271542AbTGQST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:19:29 -0400
Received: from [193.137.96.140] ([193.137.96.140]:37807 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id S271556AbTGQSRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:17:24 -0400
X-Spam-Filter: check_local@dwarf.utad.pt by digitalanswers.org
X-Spam-Header: 550.Reject.Received:count_Received
Message-ID: <3F16E9D6.8070705@alvie.com>
Date: Thu, 17 Jul 2003 19:24:22 +0100
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
References: <20030717141847.GF7864@charite.de> <1058452714.9048.4.camel@dhcp22.swansea.linux.org.uk> <20030717144549.GL7864@charite.de>
In-Reply-To: <20030717144549.GL7864@charite.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>* Alan Cox <alan@lxorguk.ukuu.org.uk>:
>
>  
>
>>>* The IDE ATA disk works, but upon reboot, the machine does NOT find
>>>  the IDE harddisk anymore! Tis means I have to turn the machine off
>>>  and on again (since it has no reset button)
>>>      
>>>
>>Curious. Could be the BIOS doesn't know how to do hard disk power
>>management especially if its quite an old PC 
>>    
>>
>
>It's last year's model. Not quite old I'd say.
>
>  
>
I have the same problem here with a toshiba satellite (with 
2.6.0-test1).  It boots ok, then when I reboot it stops before loading 
lilo (pure blank screen with only cursor on it). If I switch off/on it 
goes OK.

This wasn't happening in 2.5.66. ACPI S3 suspend/resume is working fine 
though. Could this be related to ACPI in any way?

Álvaro Lopes

