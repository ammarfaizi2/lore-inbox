Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319502AbSIMCHf>; Thu, 12 Sep 2002 22:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSIMCHf>; Thu, 12 Sep 2002 22:07:35 -0400
Received: from host.greatconnect.com ([209.239.40.135]:18707 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319502AbSIMCHd>; Thu, 12 Sep 2002 22:07:33 -0400
Message-ID: <3D8149F6.9060702@rackable.com>
Date: Thu, 12 Sep 2002 19:14:14 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Stephen Lord <lord@sgi.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-i386/page.h:#define __VMALLOC_RESERVE       (128 << 20)
include/asm/page.h:#define __VMALLOC_RESERVE    (128 << 20)


Andrea Arcangeli wrote:

>On Thu, Sep 12, 2002 at 07:47:48PM -0500, Stephen Lord wrote:
>  
>
>>How much memory is in the machine by the way? And Andrea, is the
>>vmalloc space size reduced in the 3G user space configuration?
>>    
>>
>
>it's not reduced, it's the usual 128m.
>
>BTW, I forgot to say that to really take advantage of CONFIG_2G one
>should increase __VMALLOC_RESERVE too, it's not directly in function of
>the CONFIG_2G.
>

So how much do you recommend increasing it?   Currently it's:
include/asm-i386/page.h:#define __VMALLOC_RESERVE       (128 << 20)
include/asm/page.h:#define __VMALLOC_RESERVE    (128 << 20)

