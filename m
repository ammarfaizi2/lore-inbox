Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSFWI3O>; Sun, 23 Jun 2002 04:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSFWI3O>; Sun, 23 Jun 2002 04:29:14 -0400
Received: from [203.117.131.12] ([203.117.131.12]:15547 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S316996AbSFWI3N>; Sun, 23 Jun 2002 04:29:13 -0400
Message-ID: <3D1586C7.2000107@metaparadigm.com>
Date: Sun, 23 Jun 2002 16:28:55 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: "Lu, Yan P" <Yan-Ping.Lu@team.telstra.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: FW:  netgear ga621
References: <73388857A695D31197EF00508B08F29807216B5F@ntmsg0131.corpmail.telstra.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could try the ns83820 driver that comes with the kernel.
I'd guess the RedHat 2.4.18 kernel would have the req'd
optical transciever support (it's in stock 2.4.18 version)

It works with my GA621 cards.

~mc

On 06/22/02 06:06, Lu, Yan P wrote:

>Hello 
>
>  
>
>>I have got trouble with netgear ga621. I am running redhat 7.3 which the
>>kernel version is 2.4.18-3. I successfully compiled driver provided by
>>netgear, but could not get card works. I used the following command to
>>load the driver[1]:
>>[1]:
>> # insmod gam.o
>>
>>Then, I have got link LED on the card goes off, and /var/log/message only
>>shows the following message[2]:
>>[2]:
>>Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter Driver,
>>version 1.02, May 15 2001, linux 2.4.x kernel
>>Jun 22 07:37:51 AN131 kernel: 
>>Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter : eth1
>>Jun 22 07:37:51 AN131 kernel: 
>>Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter : eth2
>>
>>I have also used the command to active the card[3]:
>>[3]:
>># ifconfig eth1 10.2.2.2
>>
>>log/message does not do any changes, and link LED is still off.
>>
>>    
>>
>Anyone can tell me how to make this card works. 
>  
>
>>*	what's the configuration I need to do to make this card works, 
>>*	which configuration points I can check, 
>>*	what's the proper log message I should see if the card works ok. 
>>
>>Thank you in advance for your help.
>>
>>Regards,
>>Yan
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


