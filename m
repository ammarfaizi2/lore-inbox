Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTJOVON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTJOVOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:14:02 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:63981 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S264351AbTJOVNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:13:18 -0400
Message-ID: <3F8DB745.5030401@hotpop.com>
Date: Thu, 16 Oct 2003 02:38:21 +0530
From: dacin <dacin@hotpop.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031005
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug and /etc/init.d/hotplug
References: <Sea2-F47xegIqunLOyD000050c7@hotmail.com>
In-Reply-To: <Sea2-F47xegIqunLOyD000050c7@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See /etc/rc.d/rc.sysinit for the magic ....

Regards
Dacodecz

sting sting wrote:

> Hello,
> I am running RedHat 9 with 2.4.20-8  kernel ;
> Now , I have a questo about hotplug:
> I have hotplug-2002_04_01-17 installed (rpm);
>
> Now , I read the readme of this rpm ;
> in their "installing"  section , clause 5 , it says:
> # cp etc/rc.d/init.d/hotplug /etc/rc.d/init.d/hotplug
> # cd /etc/rc.d/init.d
> # chkconfig --add hotplug
>
> I checked on my machine and there is no "hotplug" file in that folder.
> Nevertheless, hotplugin works (because when I plug a USB camera
> I can see in the kernel log (/var/log/messages)  messages which start 
> with
> /etc/hotplug/usb.agent
>
> I also looked at the kernel code (method "call_polcy" in usb.c )
> and it doesn't seems to me that the hotplug in /etc/init.d is needed .
>
> can anybody make some clarifications ?
> sting
>
> _________________________________________________________________
> The new MSN 8: advanced junk mail protection and 2 months FREE* 
> http://join.msn.com/?page=features/junkmail
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



