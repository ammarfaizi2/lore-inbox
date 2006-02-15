Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWBOOTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWBOOTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBOOTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:19:21 -0500
Received: from vmaila.mclink.it ([195.110.128.108]:35847 "EHLO
	vmaila.mclink.it") by vger.kernel.org with ESMTP id S932102AbWBOOTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:19:20 -0500
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, "'Dave Jones'" <davej@redhat.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <airlied@linux.ie>, <dri-devel@lists.sourceforge.net>
Subject: Re: 2.6.16-rc3: more regressions
Date: Wed, 15 Feb 2006 15:17:30 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAANQL/eIi7wEWXuWvAG6xFngEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Module                  Size  Used by
>appletalk              27696  2
>ax25                   45784  2
>ipx                    21164  2
>radeon                 94112  0
>
>this of course on 2.6.15, since 2.6.16 completely hangs, and no other info
can be gathered.


BTW, modprobe-ing radeon.ko (no Xorg started), 2.6.16-rc1 stays up and this
is dmesg:

... snip ...

ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.21.0 20051229 on minor 0

... snip ...

then, as soon as Xorg is started, the system hangs.

Mauro

