Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSKBXbh>; Sat, 2 Nov 2002 18:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSKBXbh>; Sat, 2 Nov 2002 18:31:37 -0500
Received: from lakemtao08.cox.net ([68.1.17.113]:41387 "EHLO
	lakemtao08.cox.net") by vger.kernel.org with ESMTP
	id <S261501AbSKBXbg> convert rfc822-to-8bit; Sat, 2 Nov 2002 18:31:36 -0500
From: steve roemen <sdroemen@cox.net>
Reply-To: sdroemen@cox.net
To: steve.roemen@wcom.com,
       "Linux-Kernel development list (E-mail)" 
	<linux-kernel@vger.kernel.org>
Subject: Re: PS/2 mouse in 2.5.45
Date: Sat, 2 Nov 2002 17:38:01 -0600
User-Agent: KMail/1.4.7
References: <001a01c282a0$d1b280f0$e70a7aa5@WSXA7NCC106.wcomnet.com>
In-Reply-To: <001a01c282a0$d1b280f0$e70a7aa5@WSXA7NCC106.wcomnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211021738.01510.sdroemen@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm  i recompiled it as a module(psmouse.c), then loaded it after the kernel 
came up, and all is well...  

i'll do some more playing around tommorow.

-steve roemen


On Saturday 02 November 2002 12:51 pm, steve roemen wrote:
> hey all,
>
> not a big bug, but still a bug.  the mouse in 2.4.45 will freak out, and
> start jumping all over the screen.
>
> my system is a dual athlon 1800+ (tyan s2466n-4m)  the mouse is an M$
> Intellimouse explorer.  I'm using the usb to PS/2 adapter.
>
> is there a fix for this problem?
>
>
> Nov  1 22:14:06 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:14:36 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:15:02 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
> bytes a
> way.
> Nov  1 22:15:11 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:15:17 lws04 last message repeated 2 times
> Nov  1 22:15:18 lws04 kernel: APIC error on CPU1: 00(02)
> Nov  1 22:15:18 lws04 kernel: APIC error on CPU0: 00(02)
> Nov  1 22:15:19 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
> bytes a
> way.
> Nov  1 22:15:21 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:16:02 lws04 last message repeated 2 times
> Nov  1 22:16:07 lws04 last message repeated 2 times
> Nov  1 22:16:09 lws04 kernel: APIC error on CPU1: 02(02)
> Nov  1 22:16:09 lws04 kernel: APIC error on CPU0: 02(02)
> Nov  1 22:16:34 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:16:38 lws04 kernel: APIC error on CPU0: 02(02)
> Nov  1 22:16:38 lws04 kernel: APIC error on CPU1: 02(02)
> Nov  1 22:16:45 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:17:15 lws04 last message repeated 5 times
> Nov  1 22:20:41 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:20:43 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:20:45 lws04 kernel: APIC error on CPU1: 02(02)
> Nov  1 22:20:45 lws04 kernel: APIC error on CPU0: 02(02)
> Nov  1 22:24:18 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:24:27 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
> bytes a
> way.
> Nov  1 22:25:40 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
> bytes a
> way.
>
> I rebooted with the noapic flag. and now I see this when the mouse freaks
> out:
>
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> psmouse.c: Lost synchronization, throwing 2 bytes away.
> psmouse.c: Lost synchronization, throwing 1 bytes away.
>
>
> thanks
>
> -Steve Roemen
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

