Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSFKDG1>; Mon, 10 Jun 2002 23:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSFKDG0>; Mon, 10 Jun 2002 23:06:26 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:17509 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S316668AbSFKDG0>; Mon, 10 Jun 2002 23:06:26 -0400
Message-ID: <3D056912.60104@blue-labs.org>
Date: Mon, 10 Jun 2002 23:05:54 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Jacob Luna Lundberg <kernel@gnifty.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2, compile warnings/failures
In-Reply-To: <Pine.LNX.4.44.0206101920330.17269-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 565; timestamp 2002-06-10 23:05:41, message serial number 6060
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My choice was to drop the \n, I don't like very short statements spread 
over multiple lines especially if I'm grepping for things.

That's why I chose not to include a \n.

-d

Thunder from the hill wrote:

>Hi,
>
>On Mon, 10 Jun 2002, Jacob Luna Lundberg wrote:
>  
>
>>On Mon, 10 Jun 2002, Thunder from the hill wrote:
>>    
>>
>>>-			printk(KERN_WARNING "i2o: Could not quiesce %s."  "
>>>-				Verify setup on next system power up.\n", c->name);
>>>+			printk(KERN_WARNING "i2o: Could not quiesce %s."
>>>+			       "Verify setup on next system power up.\n",
>>>+			       c->name);
>>>      
>>>
>>Don't we lose a \n if you do that?  Speaking of, is "\n" better, or "  "
>>I wonder...  ;)
>>    
>>
>
>You're right, here comes the accurate version:
>
>  
>

