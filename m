Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316062AbSEJQKx>; Fri, 10 May 2002 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316059AbSEJQJu>; Fri, 10 May 2002 12:09:50 -0400
Received: from fiona.siteprotect.com ([66.113.135.14]:10248 "HELO
	fiona.siteprotect.com") by vger.kernel.org with SMTP
	id <S316063AbSEJQIl>; Fri, 10 May 2002 12:08:41 -0400
Message-ID: <3CDBEF8B.3010901@hostway.net>
Date: Fri, 10 May 2002 11:04:27 -0500
From: Nicholas Harring <nharring@hostway.net>
Reply-To: nharring@hostway.net
Organization: Hostway Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <3CDBFF5B.32550.1364FB2@localhost>	<3CDBE7EB.9060605@mandrakesoft.com>	<3CDBEC6A.9020600@hostway.net> <20020510.084948.99859388.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously some form of driver is necessary to access the device, whether 
or not we're pushing fully formed IP packets or raw payload. Or is that 
a userland problem and I'm just not understanding the flow from 
userspace through the kernel and to the driver properly?

Cheers,
Nicholas Harring

David S. Miller wrote:
>    From: Nicholas Harring <nharring@hostway.net>
>    Date: Fri, 10 May 2002 10:51:06 -0500
> 
>    And how about when an SMP system isn't enough?
> 
> Demonstrate this.
> 
> Putting the whole implementation on the cards firmware is feasible,
> you don't need SMP.  It's totally doable and Linux needs to see
> none of the details.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



