Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVDAOn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVDAOn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVDAOn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:43:58 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:25105 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262745AbVDAOnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:43:40 -0500
Message-ID: <8294.195.245.190.93.1112366538.squirrel@www.rncbc.org>
In-Reply-To: <20050401125219.GA2560@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
    <20050401104724.GA31971@elte.hu>
    <55598.195.245.190.93.1112357613.squirrel@www.rncbc.org>
    <20050401125219.GA2560@elte.hu>
Date: Fri, 1 Apr 2005 15:42:18 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "Steven Rostedt" <rostedt@goodmis.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Apr 2005 14:43:39.0441 (UTC) FILETIME=[315CAA10:01C536C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> thx - i've uploaded -43-01 which should fix this.
>

Now it's dying-on-the-beach:
.
.
.
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.12-rc1-RT-V0.7.43-01.0; fi
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/usb/storage/usb-storage.ko
needs unknown symbol __compat_down_failed_interruptible
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/usb/storage/usb-storage.ko
needs unknown symbol __compat_up_wakeup
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/parport/parport.ko
needs unknown symbol __compat_down_failed_interruptible
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/parport/parport.ko
needs unknown symbol __compat_up_wakeup
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/net/ppp_async.ko
needs unknown symbol __compat_up_wakeup
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/net/ppp_async.ko
needs unknown symbol __compat_down_failed
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/ieee1394/ieee1394.ko
needs unknown symbol __compat_down_failed_trylock
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/ieee1394/ieee1394.ko
needs unknown symbol __compat_down_failed_interruptible
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/ieee1394/ieee1394.ko
needs unknown symbol __compat_up_wakeup
WARNING:
/lib/modules/2.6.12-rc1-RT-V0.7.43-01.0/kernel/drivers/ieee1394/ieee1394.ko
needs unknown symbol __compat_down_failed
make: *** [_modinst_post] Error 1

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

