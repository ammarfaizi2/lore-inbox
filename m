Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWGGMpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWGGMpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWGGMpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:45:54 -0400
Received: from mail.gmx.net ([213.165.64.21]:9164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932141AbWGGMpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:45:54 -0400
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain; charset="utf-8"
Date: Fri, 07 Jul 2006 14:45:52 +0200
From: "Uwe Bugla" <uwe.bugla@gmx.de>
Message-ID: <20060707124552.9650@gmx.net>
MIME-Version: 1.0
Subject: boot errors in kernels 2.6.17-mm6 plus 2.6.18-rc1
To: zippel@linux-m68k.org
X-Authenticated: #8359428
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman, hi John Stultz,
Andrew told me that you were working on that issue.

I use Debian Etch in connection with latest kernel-headers and kernels.
My system is a Pentium 4, the graphics card is an ATI Rage 128 Pro with 32 MB RAM.
When I compile both mentioned kernels, I can activate FB and FB_VESA.
But if I add „vga=791“ to menu.lst (i. e. as an additional parameter for the kernel to boot) two bugs happen:
1. The kernel takes an eternity to boot, taking about 4 long breaks to come up at all
2. the AT keyboard (atkbd.c) is not functional (i. e. I type in one letter at boot prompt and this letter is being duplicated for about 50 times

If I leave out the kernel parameter (vga=791) evrything is working fine so far without any faults.

Would you please fix this in the above mentioned kernels, so that I can use my system again with a startup screen including the small little penguin at startup?

Regards

Uwe

P. S. 1: This issue is not, as I thought first, a atkbd.c issue for Dmitry Torokhov, but a pure framebuffer issue.
P. S. 2: Is that email OK so far or should I open an entry at kernel.bugzilla?

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
