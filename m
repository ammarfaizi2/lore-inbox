Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQLTPPO>; Wed, 20 Dec 2000 10:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLTPPE>; Wed, 20 Dec 2000 10:15:04 -0500
Received: from gear.torque.net ([204.138.244.1]:40199 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129561AbQLTPO4>;
	Wed, 20 Dec 2000 10:14:56 -0500
Message-ID: <3A40BF53.400EF44B@torque.net>
Date: Wed, 20 Dec 2000 09:16:51 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: Oops with 2.4.0-test13pre3 - swapoff
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zdenek Kabelac wrote:
> This is oops I've got when rebooting after some heavy disk activity on
> my SMP system:
> 
> Written by hand:
> 
> kernel BUG swap_state.c:78!
[snip]

Same here during a halt of a RH 6.2 based K6-2 500 MHz
UP machine running lk240t13p3. The machine had been on
for a while and had built a kernel amongst other things.

Lead up was:
$ halt
.....
Sending all processes the KILL signal    [OK]
Turning off swap VM: __lru_cache_del, found unknown page ?!
kernel BUG at swap_state.c:78
....

Doug Gilbert


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
