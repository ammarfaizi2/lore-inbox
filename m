Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265052AbSJPPOZ>; Wed, 16 Oct 2002 11:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265053AbSJPPOZ>; Wed, 16 Oct 2002 11:14:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265052AbSJPPOY>;
	Wed, 16 Oct 2002 11:14:24 -0400
Message-ID: <3DAD83AD.4000306@pobox.com>
Date: Wed, 16 Oct 2002 11:20:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016143822.GA4320@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>>AFAIK Linus and Al Viro (and myself <g>) have always considered ioctls 
>>an ugly -ism that should have never made it into Unix.  Over and above 
>>the Unix/VFS design problems with ioctl(2), ioctl(2) is a pain for 
>>people like David Miller who must maintain 32<->64 bit ioctl translation 
>>layers for their architecture.  ia64 and x64-64 must do this too.  Each 
>>ioctl you add is an additional headache for them.
> 
> 
> And ppc64 :) Lately Dave, Andi and I seem to be spending too much time
> bouncing fixes around for 32/64 bit ioctl and syscall translation code.


Tangent:  everyone agrees a shared ioctl32 would be immensely useful, 
but noone has bothered ;-)

