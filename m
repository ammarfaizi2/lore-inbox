Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272404AbTHMMYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272568AbTHMMYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:24:11 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:11691 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S272404AbTHMMXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:23:33 -0400
Message-ID: <3F3A2DB9.7030601@home.ro>
Date: Wed, 13 Aug 2003 15:23:21 +0300
From: Nufarul Alb <nufarul.alb@home.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: multibooting the linux kernel
References: <3F396C04.90608@home.ro> <20030813072053.A25803@infradead.org>
In-Reply-To: <20030813072053.A25803@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Aug 13, 2003 at 01:36:52AM +0300, Nufarul Alb wrote:
>  
>
>>There is a patch for the kernel that make it able to preload modules 
>>before the acutal booting.
>>
>>I wonder if this feature will be included in the official linux kernel.
>>    
>>
>
>Mutliboot support would be nice, not sure about the module loading thing.
>
>But there's a bunch of issues with the paches:
>
>(1) please port to 2.6 first because
>      (a) there's not chance this will get into 2.4
>      (b) 2.6 has the inkernel module loader so you don't have to duplicate
>          so much loader code.
>(2) please convert from GNU to Linux style
>(3) please use the predefined __ASSEMBLY__ instead of ASM
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Those are not my patches. They belong to a certain Christian Koenig. He 
doesn't mantain them any more and I'm searching for someone to mantain 
this project.

I know very little about kernel programming, but I liked the idea of 
having such a feature in the kernel. It gives more freedom in compiling 
the kernel. Maybe one day we would have the main piece of the kernel as 
a standard and only have to recompile modules. THIS HAS NOTHING TO DO 
WITH MICROKERNELS. Multibooting is a different stuff.

SO, if somebody knows who might want to update this patches, it would be 
great.

Thanks!!



