Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316041AbSEJPzY>; Fri, 10 May 2002 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316044AbSEJPzX>; Fri, 10 May 2002 11:55:23 -0400
Received: from fiona.siteprotect.com ([66.113.135.14]:32263 "HELO
	fiona.siteprotect.com") by vger.kernel.org with SMTP
	id <S316041AbSEJPzU>; Fri, 10 May 2002 11:55:20 -0400
Message-ID: <3CDBEC6A.9020600@hostway.net>
Date: Fri, 10 May 2002 10:51:06 -0500
From: Nicholas Harring <nharring@hostway.net>
Reply-To: nharring@hostway.net
Organization: Hostway Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>, chen_xiangping@emc.com,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A42@srgraham.eng.emc.com> <3CDBFF5B.32550.1364FB2@localhost> <3CDBE7EB.9060605@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And how about when an SMP system isn't enough? Should I have to 
re-engineer my network storage architecture when hardware exists that'll 
increase throughput if a simple device driver gets written? Don't forget 
that with 64 bit PCI that the limit of the bus has been raised, and with 
impending technologies like Infiniband and Hypertransport that limit 
will be raised again. At that point devoting main processor resources to 
something better handled by specialty hardware really stops making 
sense, if that specialty hardware is low-cost (oughta be) and effective 
(still debatable).

Nicholas Harring
Hostway Corporation


Jeff Garzik wrote:
> Pedro M. Rodrigues wrote:
> 
>>   Actually there is. Think iSCSI. Have a look at this article at 
>> LinuxJournal - http://linuxjournal.com/article.php?sid=4896 .
>>
> 
> Ug...  why bother?  Just buy an SMP system at that point...
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



