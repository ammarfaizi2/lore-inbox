Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRHXP0i>; Fri, 24 Aug 2001 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272133AbRHXP0S>; Fri, 24 Aug 2001 11:26:18 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:45695
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S272122AbRHXP0Q>; Fri, 24 Aug 2001 11:26:16 -0400
Message-ID: <3B867225.5010008@fugmann.dhs.org>
Date: Fri, 24 Aug 2001 17:26:29 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] const initdata.
In-Reply-To: <E15aIjC-0005vy-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah.. I misread the first posting.

Then we are down to zero .h and 43 .c files that are affected.
(a total of 121 lines containing 'const' before '__initdata')

Can these be fixed without testing (ie. through a script).
If so, I'm willing to post a patch.

Regards
Anders Fugmann





Alan Cox wrote:
>>How "bad" is it to have __initdata declared static?
>>
> 
> static is fine as it just changes name scoping, const however can try and
> put data in other places such as code segments. That breaks stuff when
> compiling with certain gcc versions
> 
> 


