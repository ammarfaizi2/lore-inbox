Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271357AbTHHPFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTHHPFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:05:04 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:37641 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271357AbTHHPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:05:00 -0400
Message-ID: <3F33BF33.8070601@techsource.com>
Date: Fri, 08 Aug 2003 11:18:11 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jasper Spaans <jasper@vs19.net>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com> <20030808065230.GA5996@spaans.vs19.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jasper Spaans wrote:
> On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:
> 
> 
>>>It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
>>>I've just comiled all affected files (that is, the config resulting from
>>>make allyesconfig minus already broken stuff) succesfully on i386.
>>
>>Arrrgh! You can't be serious!
> 
> 
> Yes, I am bloody serious; this patch might look purely cosmetic at first
> sight.. yet, there's a technical reason for at least one part of it. Grep
> and see the horror:
> 
> $ egrep -ni 'flavou?r' fs/nfs/inode.c
> [snip]
> 1357:	rpc_authflavor_t authflavour;
> [snip]


Ah, for a moment, I was worried that someone was talking about text in 
comments.

Yes, when it comes to spelling of words in variable and type names, I 
think it would be a good idea to be consistent.

What is Linus's preferred spelling?  Let's use that.


