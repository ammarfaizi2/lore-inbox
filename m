Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTI2Pd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTI2Pd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:33:29 -0400
Received: from mail2.cc.huji.ac.il ([132.64.1.18]:52445 "EHLO
	mail2.cc.huji.ac.il") by vger.kernel.org with ESMTP id S263598AbTI2PdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:33:20 -0400
Message-ID: <3F785094.5070500@mscc.huji.ac.il>
Date: Mon, 29 Sep 2003 18:32:36 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030913 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <lkml001@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test6-mm1 zombie hotplug/event processes
References: <20030929151957.GA8260@vrfy.org>
In-Reply-To: <20030929151957.GA8260@vrfy.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.21.0.1; VDF: 6.21.0.55; host: mail2.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this too

Kay Sievers wrote:

>Hi,
>the hotplug/event processes are hanging in my task list.
>Everything if working, but as a example: USB-mouse disconnect/connect gets 6 more
>zombies.
>
>2.4 is okay. System is debian sid with hotplug package 20030924.
>
>Any idea, why this happens?
>
>Thanks
>Kay
>
>
>pim:~# ps afx
>  PID TTY      STAT   TIME COMMAND
>    1 ?        S      0:03 init [2]  
>    2 ?        SWN    0:00 [ksoftirqd/0]
>    3 ?        SW<    0:00 [events/0]
>   41 ?        Z<     0:00  \_ [events/0] <defunct>
>   58 ?        Z<     0:00  \_ [hotplug] <defunct>
>   68 ?        Z<     0:00  \_ [hotplug] <defunct>
>   79 ?        Z<     0:00  \_ [hotplug] <defunct>
>  123 ?        Z<     0:00  \_ [hotplug] <defunct>
>  128 ?        Z<     0:00  \_ [hotplug] <defunct>
>  134 ?        Z<     0:00  \_ [hotplug] <defunct>
>  140 ?        Z<     0:00  \_ [hotplug] <defunct>
>  145 ?        Z<     0:00  \_ [hotplug] <defunct>
>  151 ?        Z<     0:00  \_ [hotplug] <defunct>
>  157 ?        Z<     0:00  \_ [hotplug] <defunct>
>  162 ?        Z<     0:00  \_ [hotplug] <defunct>
>  168 ?        Z<     0:00  \_ [hotplug] <defunct>
>  186 ?        Z<     0:00  \_ [events/0] <defunct>
>  188 ?        Z<     0:00  \_ [events/0] <defunct>
>  190 ?        Z<     0:00  \_ [hotplug] <defunct>
>  196 ?        Z<     0:00  \_ [hotplug] <defunct>
>  221 ?        Z<     0:00  \_ [events/0] <defunct>
>  462 ?        Z<     0:00  \_ [events/0] <defunct>
>  464 ?        Z<     0:00  \_ [events/0] <defunct>
>  466 ?        Z<     0:00  \_ [events/0] <defunct>
>  488 ?        Z<     0:00  \_ [hotplug] <defunct>
>  497 ?        Z<     0:00  \_ [events/0] <defunct>
>  499 ?        Z<     0:00  \_ [events/0] <defunct>
>  501 ?        Z<     0:00  \_ [events/0] <defunct>
>  503 ?        Z<     0:00  \_ [events/0] <defunct>
>  505 ?        Z<     0:00  \_ [events/0] <defunct>
>  507 ?        Z<     0:00  \_ [events/0] <defunct>
>  551 ?        Z<     0:00  \_ [hotplug] <defunct>
>  557 ?        Z<     0:00  \_ [hotplug] <defunct>
>  669 ?        Z<     0:00  \_ [events/0] <defunct>
>    4 ?        SW<    0:00 [kblockd/0]
>    5 ?        SW     0:00 [pdflush]
>    6 ?        SW     0:00 [pdflush]
>    7 ?        SW     0:00 [kswapd0]
>    8 ?        SW<    0:00 [aio/0]
>    9 ?        SW<    0:00 [aio_fput/0]
>   10 ?        SW     0:00 [kseriod]
>...
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


