Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRI3L0T>; Sun, 30 Sep 2001 07:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273328AbRI3L0K>; Sun, 30 Sep 2001 07:26:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:26780 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S273305AbRI3L0B>;
	Sun, 30 Sep 2001 07:26:01 -0400
Date: Sun, 30 Sep 2001 13:26:28 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109301126.NAA24615@harpo.it.uu.se>
To: sshah@progress.com
Subject: Re: Broken APIC detection 2.4.10?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2001 18:21:54 -0400, Sujal Shah wrote:

>I just switched up to 2.4.10 on my Sony Vaio N505VX.  In the boot
>messages, I see near the top:
>
>Local APIC disabled by BIOS -- reenabling.
>Could not enable APIC!
>
>/proc/interrupts shows XT-PIC for all the interrupts.  This was not the
>case before.  Of course, I'm seeing other weirdness which is related
>(the YMFPCI based sound card won't reset on reboot without shutting down
>completely).

Please elaborate: What does "This" in "This was not the case before."
refer to? The "Could not enable APIC!" boot message or the XT-PIC in
/proc/interrupts?

2.4.10 merged code from 2.4-ac which (in some .configs) will attempt
to enable the CPU's local APIC. The boot message above is printed if
your CPU doesn't have one.

>Anyone have any ideas why this is?  The APIC stuff was getting detected
>fine in 2.4.7.

Can you send me your .configs and boot logs for both 2.4.7 and 2.4.10?
I don't think there is an actual problem, but I'd like to make sure.

/Mikael
