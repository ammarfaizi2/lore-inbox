Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLTKdo>; Wed, 20 Dec 2000 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLTKde>; Wed, 20 Dec 2000 05:33:34 -0500
Received: from hermes.mixx.net ([212.84.196.2]:5382 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129415AbQLTKd0>;
	Wed, 20 Dec 2000 05:33:26 -0500
Message-ID: <3A4083D2.BC684527@innominate.com>
Date: Wed, 20 Dec 2000 11:02:58 +0100
From: Juri Haberland <juri.haberland@innominate.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Al Peat <al_kernel@yahoo.com>
Cc: myself <al_peat@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Purging the Buffer Cache
In-Reply-To: <20001220040634.26347.qmail@web10102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Peat wrote:
> 
>   Is there any way to completely purge the buffer
> cache -- not just the write requests (ala 'sync' or
> 'update'), but the whole thing?  Can I just call
> invalidate_buffers() or destroy_buffers()?
> 
>   I know, why in the world would a person do such a
> thing?  Research.  It'd be easier for me to write a
> little program or add it to a module than wait for a
> reboot each time I need a clean buffer cache.

What about the ioctl BLKFLSBUF ?
If you are running a SuSE distrib there is already a tool called flushb
that does what you want. If not, you can download the simple tool from
http://innominate.org/~juri/flushb.tar.gz

Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
