Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVEMPkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVEMPkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVEMPky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:40:54 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:50488 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262299AbVEMPhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:37:12 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,107,1114984800"; 
   d="scan'208"; a="9295733:sNHT26934400"
Message-ID: <4284C9A7.7010400@fujitsu-siemens.com>
Date: Fri, 13 May 2005 17:37:11 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: Again: UML on s390 (31Bit)
References: <OFA2B0C767.4C8614D3-ONC1257000.00541583-C1257000.0054CC70@de.ibm.com>
In-Reply-To: <OFA2B0C767.4C8614D3-ONC1257000.00541583-C1257000.0054CC70@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
>>Meanwhile I've tried.
>>
>>Your patch absolutely doesn't change host's behavior in the situation,
>>that is relevant to UML.
> 
> 
> And as I understand that is because the SIGTRAP is not delivered
> by the normal signal mechanism.
Yes.

BTW: I still can't see any loop in the kernel, that could call
do_signal() multiple times without returning to user in between.
For my understanding: do I miss something? If so, where is the loop?

Regards
	Bodo

> 
> 
>>I've prepared and attached a small program that easily can reproduce
>>the problem. I hope this will help to find a viable solution.
> 
> 
> That is cool, thanks. Will certainly speed up debugging on my side.
> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH
> 
