Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSBOKUu>; Fri, 15 Feb 2002 05:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSBOKUi>; Fri, 15 Feb 2002 05:20:38 -0500
Received: from vaak.stack.nl ([131.155.140.140]:12041 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S289482AbSBOKUX>;
	Fri, 15 Feb 2002 05:20:23 -0500
Date: Fri, 15 Feb 2002 11:20:21 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.5.5-pre1: Deadlocks and ALSA driver problems
Message-ID: <20020215110243.U68580-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Still fighting with the debug tools (I'm new to kernel debugging), but
maybe this info is useful to others:

2.5.5-pre1 deadlocked completely about 7 times in 40 minutes. The Magic
SysRq key didn't work anymore. Don't know if it is related, but after I
recompiled the ALSA driver as modules, the system was stable for about 4
hours. (With ALSA modules loaded, playing music, and I rebooted it myself
afterwards.)

Besides: the ALSA /proc interface is terribly broken, any cat
/proc/asound/... results in a no such device error. The ALSA /dev entries
return the same errors while opening them, but the OSS emulation layer
works fine.

System Info:
PII-333 SMP on Asus P2L97-DS (Intel LX chipset), 512 MB RAM
SB Live 5.1 soundcard

The kernel is compiled with ALSA driver and Preemptive=Y

I hope to provide you better emails in the future.

Jos

