Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130277AbRACB13>; Tue, 2 Jan 2001 20:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRACB1T>; Tue, 2 Jan 2001 20:27:19 -0500
Received: from mail-ffm-p.arcor-ip.de ([145.253.2.10]:44743 "EHLO
	mail.arcor-ip.de") by vger.kernel.org with ESMTP id <S130277AbRACB1G>;
	Tue, 2 Jan 2001 20:27:06 -0500
Date: Tue, 2 Jan 2001 23:22:55 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Timeout: AT keyboard not present?
Message-ID: <20010102232255.A355@asterix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <87vgs2m7z8.fsf@relativistic.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.7-current-20000808i
In-Reply-To: <87vgs2m7z8.fsf@relativistic.homeip.net>; from kuantiko@escomposlinux.org. on Sat, Dec 30, 2000 at 01:03:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes=FAs?=!

On Sat, 30 Dec 2000, Jes=FAs?= Carrete Montaña wrote:

> 
> I receive this message very often in console, in every situation: when
> I'm coding and when I'm playing tetrinet. It's quite annoying, mostly
> because it fills my screen of garbage (I'll have to buy a new CTRL and
> L keys). What's the prolem? It only happens (I think) with >2.2.17
> kernels (including 2.4.0-test12).
> Please let me know if you need more information.
> 
> Un saludo.

Just wanted to confirm the above mentioned problem.

2 days ago i upgraded to 2.4.0-prelease, today suddenly i had the same
symptom. I've been running 2.4.0-test10 since it's been released and never
saw this happen there.

See the log files :

Jan  2 21:15:44 obelix rpc.mountd: authenticated unmount request from
 192.168.1.2:758 for /home/sfr/Mail (/home/sfr/Mail)
Jan  2 21:20:24 asterix kernel: keyboard: unrecognized scancode (70) - ignored
Jan  2 21:20:24 asterix last message repeated 2 times
Jan  2 21:20:24 asterix kernel: keyboard: Timeout - AT keyboard not present?
Jan  2 21:20:24 asterix kernel: keyboard: unrecognized scancode (70) - ignored
Jan  2 21:20:32 asterix last message repeated 18 times
Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 12
Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 71
Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 70
Jan  2 21:20:33 asterix kernel: keyboard: unrecognized scancode (71) - ignored
Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 70
Jan  2 21:20:34 asterix kernel: keyboard: unrecognized scancode (70) - ignored
Jan  2 21:20:47 asterix last message repeated 13 times
Jan  2 21:20:48 asterix kernel: keyboard: unknown scancode e0 14
Jan  2 21:20:48 asterix kernel: keyboard: unknown scancode e0 70
Jan  2 21:20:48 asterix kernel: keyboard: unrecognized scancode (70) - ignored
Jan  2 21:20:48 asterix kernel: keyboard: unrecognized scancode (70) - ignored
Jan  2 21:20:49 asterix kernel: keyboard: unknown scancode e0 75
Jan  2 21:20:49 asterix kernel: keyboard: unknown scancode e0 70

root@asterix:/usr/src/linux/scripts# ./ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux asterix 2.4.0-prerelease #4 Mon Jan 1 21:24:04 CET 2001 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         rtc w83781d sensors i2c-isa i2c-viapro i2c-core

Have a nice day, and, happy new year !

	Stefan


-- 
If you fool around with something long enough, it will eventually break.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
