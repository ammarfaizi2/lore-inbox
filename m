Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUBHMAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 07:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUBHMAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 07:00:30 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:8318 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263513AbUBHMAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 07:00:22 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: psmouse.c: .... Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Date: Sun, 8 Feb 2004 09:00:21 +0000
User-Agent: KMail/1.6
References: <4025D4BF.7010309@fire-eyes.dynup.net>
In-Reply-To: <4025D4BF.7010309@fire-eyes.dynup.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402080900.21392.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You disable CONFIG_PREEMPT? may be work around this problem

Em Dom 08 Fev 2004 06:18, fire-eyes escreveu:
>   Please CC: me, as I am not subscribed to this list.
> 
> 
> I am using kernel 2.6.2 with SMP support on an Asus A7M-266D 
> motherboard. I am using a Logitech M-BJ69 ps/2 mouse.
> 
> While in xfree, twice today I had the following happen:
> 
> While using the mouse, the pointer suddenly jumped wildly all over the 
> place, I heard exactly two PC speaker beeps, then I got control back. 
> This took about a quarter second in total. After that, no mouse button 
> worked, including wheels.
> 
> I ctl-alt-backspace out of xfree. I check my load and it is high. I'm 
> using xfce 4.0.3 window manager, and xfwm4 is taking up 99.9% of cpu. I 
> need to kill -9 it. Not sure if xfce4 is actually a problem, I don't see 
> how it would affect the mouse.
> 
> Both times I got the following error in logs:
> 
> kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost 
> synchronization, throwing 3 bytes away.
> 
> Here is some more info on my system:
> 
> Gentoo Linux
> glibc-2.3.3_pre20040117
> gcc (GCC) 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)
> xfree 4.3.99.902
> 
> Now what stands out there is the xfree version. I never had this error 
> in 4.3.0.
> 
> Starting xfree and xfce4, I get the following in logs. And yes it really 
> is this many times:
> 
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> 
> 
> Is there any further info I can provide to help solve a possible problem?
> 
> Thanks!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
