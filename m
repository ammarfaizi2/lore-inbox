Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUFROVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUFROVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUFROUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:20:33 -0400
Received: from tristate.vision.ee ([194.204.30.144]:30855 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265195AbUFROUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:20:03 -0400
Message-ID: <40D2FA24.50607@vision.ee>
Date: Fri, 18 Jun 2004 17:20:20 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hetfield666@virgilio.it,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.x ALSA sound is pretty broken
References: <1087567432.9282.17.camel@blight.blight>
In-Reply-To: <1087567432.9282.17.camel@blight.blight>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Do you have DMA enabled for your hard disk? hdparm -d /dev/hdx
will tel you ...

Lenar

Hetfield wrote:

>i've got hard problems with sound in all 2.6.x, even 2.6.7 kernels.
>
>with 2.4.2x or windows i've got no problems, so i'm sure it's kernel and
>not hardware related.
>
>the problem is that sound jumps, flickers and isn't good when harddisk
>reads lots of data (i mean not 1-2mb but 60-100mb and more)
>
>i checked irq and there is not conflict, i setted a higher and lower
>value of latency and nothing changed.
>
>i've the same problems since 2.6.0 kernels. Vanilla and Gentoo too.
>I've tried lots of solutions, like disabling preemptile kernel, adding
>alsa and oss, only oss, only alsa, as module or built-in.
>nothing changes.
>
>my audio card is a Creative SB PCI128, found by linux as
>
>
>0000:00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev
>01)
>        Subsystem: Unknown device 4942:4c4c
>        Flags: bus master, slow devsel, latency 32, IRQ 10
>        I/O ports at b000
>
>while on Windows i use es1371/3 drivers.
>however with 2.4.x i always used es1370 alsa module without problems.
>When harddisk is sleeping sound is normally good.
>
>Thanks for support
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

