Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314287AbSEBI6r>; Thu, 2 May 2002 04:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314289AbSEBI6q>; Thu, 2 May 2002 04:58:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5897 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314287AbSEBI6p>;
	Thu, 2 May 2002 04:58:45 -0400
Message-ID: <3CD0F111.2060701@evision-ventures.com>
Date: Thu, 02 May 2002 09:56:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Frank Davis <fdavis@si.rr.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.12 drivers/ide/pdcadma.c
In-Reply-To: <Pine.LNX.4.33.0205011837010.7159-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Frank Davis napisa?:
> Hello all,
>  This patch addresses the following error :
> 
> pdcadma.c: In function `pdcadma_dmaproc`
> pdcadma.c:69: too few arguments to function `ide_dmaproc`
> make[3]: *** [pdcadma.o] Error 1
> 
> Its missing the "struct request * " argument, which I set to NULL
> 
> Please review for inclusion. 


Linus please on't include this patch. It's *wrong*. The function
above has get the struct request argument as well.

