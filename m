Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbRDAJ5E>; Sun, 1 Apr 2001 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRDAJ4z>; Sun, 1 Apr 2001 05:56:55 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:28096 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132121AbRDAJ4m>;
	Sun, 1 Apr 2001 05:56:42 -0400
Date: Sun, 1 Apr 2001 11:55:59 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104010955.LAA17707@harpo.it.uu.se>
To: linux-smp@vger.kernel.org, sgarner@expio.co.nz
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Garner wrote:

>I've compiled kernel 2.4.3 on the following RH7 system, and I'm now getting
>random crashes at boot, during IO-APIC initialisation. Random meaning that
>sometimes it boots fine, other times it doesn't, and it hangs in different
>places (but always around IO-APIC stuff). It almost always hangs after a
>cold boot - if I do a Ctrl+Alt+Del then it will usually boot up OK.
>
>System: Asus CUV4X-D motherboard, Dual P3 800EB.
>...
>Any ideas?

Boot with "nmi_watchdog=0" as a boot parameter. Does it work now?

Some people have reported before here that the IO-APIC driven NMI
watchdog itself can cause boot-time hangs.

/Mikael
