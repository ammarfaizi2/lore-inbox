Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270652AbRHJVvE>; Fri, 10 Aug 2001 17:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270653AbRHJVuo>; Fri, 10 Aug 2001 17:50:44 -0400
Received: from mail.valinux.com ([198.186.202.175]:18190 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S270652AbRHJVun>;
	Fri, 10 Aug 2001 17:50:43 -0400
Message-ID: <3B7456E2.4090507@valinux.com>
Date: Fri, 10 Aug 2001 15:49:22 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: imran.badr@cavium.com
CC: linux-kernel@vger.kernel.org
Subject: Re: how to check whether other threads are waiting ..
In-Reply-To: <001701c121e3$612a27d0$6401a8c0@IMRANPC>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imran Badr wrote:

> Hi,
> 
> How can I find out in my kernel code that if mutiple threads are waiting for
> a particular semaphore?
> 
> Thanks,
> imran.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
I haven't looked at the semaphore implementation for other arch's 
closely, but on the ia32 there is a waitqueue in struct semaphore.  
Examine that to detrimine if there are processes waiting, how many, etc.

-Jeff


