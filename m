Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbRE2Cz5>; Mon, 28 May 2001 22:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbRE2Czr>; Mon, 28 May 2001 22:55:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:8835 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262020AbRE2Cze>; Mon, 28 May 2001 22:55:34 -0400
Date: Mon, 28 May 2001 22:55:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105290255.f4T2tXl24191@devserv.devel.redhat.com>
To: jgarzik@mandrakesoft.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <mailman.991098720.29883.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.991098720.29883.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch!  When compiling MySql, building sql_yacc.cc results in a ~300M
> cc1plus process size.  Unfortunately this leads the machine with 380M of
> RAM deeply into swap:
> 
> Mem:   381608K av,  248504K used,  133104K free,       0K shrd,     192K buff
> Swap:  255608K av,  255608K used,       0K free                  215744K cached
> 
> Vanilla 2.4.5 VM.

I noticed that too and there is no way around it. If we assume
a 2.5xRAM target, you must add about 704MB. In my case I had no
spare partition so I added a swapfile, as undoubtedly many
2.4 sufferers did.

-- Pete
