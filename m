Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTKIJrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 04:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTKIJrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 04:47:43 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:38079 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262228AbTKIJrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 04:47:42 -0500
Message-ID: <3FAE0D35.40908@colorfullife.com>
Date: Sun, 09 Nov 2003 10:47:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus <midian@ihme.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] forcedeth
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus wrote:

>I tested this driver for my Nforce2 mobo on 2.6.0-test9, and this driver
>seemed useless, it just printed some random numbers in my konsole (And
>trust me, it was hard to edit lilo.conf so I even could boot back to old
>kernel when all the numbers just were jumping around)
>
The driver has full debugging enabled, and that includes hexdumping the 
start of every packet. This should disappear if you replace the "#if 1" 
with "#if 0", around line 80.

> And it broke the
>other card too, ifconfig was right, now there was this card too, but no
>one from them worked. Thanks anyway.
>
Which other card? I'm interested in more details, please explain.

So far I received two bug reports:
- smp locking is broken (stupid bug, I have a fix)
- sometimes a wrong mac address is used (unresolved)

--
    Manfred

