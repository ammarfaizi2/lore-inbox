Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbTCAWHa>; Sat, 1 Mar 2003 17:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269044AbTCAWHa>; Sat, 1 Mar 2003 17:07:30 -0500
Received: from pop.gmx.net ([213.165.64.20]:20773 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S269043AbTCAWH3>;
	Sat, 1 Mar 2003 17:07:29 -0500
Date: Sat, 1 Mar 2003 23:17:46 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Alsa, Kernel OSS
Message-Id: <20030301231746.1cdf1b42.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav, Hi everyone,

I have the following problem with Kernel 2.4.20 and the alsa 0.9.0_rc6 / rc7 drivers:

When I try to load the snd-intel8x0 driver I get the message that no such device is installed. But when I first load the kernel i810_audio driver and then unload it again, I can load the snd-intel8x0 without any problems....

This happened not with 2.4.19 and alsa < 0.9.0_rc6..

Another question:

Why can't I play more than one sources on the same time with such a card? All programs which would access /dev/dsp blocks until the other programs frees the device... It isn't very useful.

I have no such problems with multiple sources as example on my SBLive or on my yamaha sound card with the snd-ymfpci driver.

Do I miss some settings?

Thank you!

Marc
