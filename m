Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270621AbRHJAIW>; Thu, 9 Aug 2001 20:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270622AbRHJAIO>; Thu, 9 Aug 2001 20:08:14 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:29916 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270621AbRHJAIC>;
	Thu, 9 Aug 2001 20:08:02 -0400
Message-Id: <200108100008.f7A08Zl16648@www.2ka.mipt.ru>
Date: Fri, 10 Aug 2001 04:08:35 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: esssound.o once more
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac1; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Some days ago problem with compiling esssound driver was erised.
And Alan Cox sad that in his -ac1 path this problem was solved, but....

Here is messages, that was occured while 2.4.7-ac9 was compiling:

drivers/sound/sounddrivers.o: In function `solo1_update_ptr':
drivers/sound/sounddrivers.o(.text+0xd6e): undefined reference to `clear_advance'
drivers/sound/sounddrivers.o: In function `solo1_write':
drivers/sound/sounddrivers.o(.text+0x2162): undefined reference to `prog_dmabuf_dac'
drivers/sound/sounddrivers.o: In function `solo1_poll':
drivers/sound/sounddrivers.o(.text+0x23b2): undefined reference to `prog_dmabuf_dac'
drivers/sound/sounddrivers.o: In function `solo1_mmap':
drivers/sound/sounddrivers.o(.text+0x2411): undefined reference to `prog_dmabuf_dac'
drivers/sound/sounddrivers.o: In function `solo1_ioctl':
drivers/sound/sounddrivers.o(.text+0x2902): undefined reference to `prog_dmabuf_dac'
drivers/sound/sounddrivers.o(.text+0x2b05): undefined reference to `prog_dmabuf_dac'
drivers/sound/sounddrivers.o(.text+0x2c38): more undefined references to `prog_dmabuf_dac' fol

And in -ac1 this messages appear once more.
But( I don't know how can I do this) I had compiled 2.4.7-ac1 some days ago with esssound support:
Linux Sombre.2ka.mipt.ru 2.4.7-ac1 #4 Fri Jul 27 06:17:13 MSD 2001 i686 unknown

but after it i can't do this once more.

Any suggestions, help and advices are wellcome :).
---
WBR. //s0mbre
