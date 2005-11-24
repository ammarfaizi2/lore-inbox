Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVKXAhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVKXAhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVKXAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:37:36 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:35438 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932605AbVKXAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:37:35 -0500
Date: Wed, 23 Nov 2005 19:37:33 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <Pine.LNX.4.61.0511232338100.4550@goblin.wat.veritas.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Michael Krufky <mkrufky@linuxtv.org>,
       Adrian Bunk <bunk@stusta.de>, Johannes Stezenbach <js@linuxtv.org>,
       Sam Ravnborg <sam@ravnborg.org>, Kirk Lapray <kirk.lapray@gmail.com>
Message-id: <200511231937.34206.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511231736.58204.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0511232338100.4550@goblin.wat.veritas.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 18:40, Hugh Dickins wrote:
>On Wed, 23 Nov 2005, Gene Heskett wrote:
>> On Wednesday 23 November 2005 16:26, Hugh Dickins wrote:
>> >They should be fixed in today's 2.6.15-rc2-git3
>> >(aside from a couple of patches to drivers/char/drm coming later).
>> >If you still have problems you think I'm responsible for, let me
>> > know.
>>
>> I'm not familiar enough with git yet to try that without some hand
>> holding :(
>
>No git familiarity needed:
>http://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
>contains the daily patches against recent -rcs
>
>Hugh

Unforch, using a 2.6.14 base, applying 2.6.15-rc2 followed by
2.6.15-rc2-git3 blows up about 24 seconds into my makeit script:

  CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c: In function `set_mtrr':
arch/i386/kernel/cpu/mtrr/main.c:225: error: `ipi_handler' undeclared
(first use in this function)
arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier
is reported only once
arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it
appears in.)
make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/mtrr] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2

??

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

