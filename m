Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRC2IR3>; Thu, 29 Mar 2001 03:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRC2IRT>; Thu, 29 Mar 2001 03:17:19 -0500
Received: from malcolm.ailis.de ([62.159.58.30]:20746 "HELO malcolm.ailis.de")
	by vger.kernel.org with SMTP id <S132689AbRC2IRN>;
	Thu, 29 Mar 2001 03:17:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Klaus Reimer <k@ailis.de>
Organization: Ailis
To: linux-kernel@vger.kernel.org
Subject: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Date: Thu, 29 Mar 2001 10:12:40 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032910124007.00454@neo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have switched from 2.2.17 to 2.4.2 and now the sound is no longer working 
on my Toshiba Tecra 8000 Notebook. In 2.2.17 I used the following modules:

mpu401
ad1848
opl3sa2 io=0x538 mss_io=0x530 mpu_io=0x330 irq=5 dma=1 dma2=0
opl3 io=0x388

This was working perfectly. I was able to control all mixer settings, the 
microphone was working and xmms was able to play nice sounds.

Then I have switched to kernel 2.4.2 and now the kernel says:

2001-03-29 10:02:50.054774500 {kern|info} kernel: ad1848/cs4248 codec driver 
Copyright (C) by Hannu Savolainen 1993-1996
2001-03-29 10:02:50.070692500 {kern|notice} kernel: opl3sa2: No cards found
2001-03-29 10:02:50.070703500 {kern|notice} kernel: opl3sa2: 0 PnP card(s) 
found.

I have nothing changed in the BIOS of the Notebook. I have set up a dual boot 
so I can switch back to kernel 2.2.17 and the sound is still working there.

I was able to enable the 8 Bit Soundblaster emulation of the Tecra with these 
modules:

uart401
sb io=0x220 irq=5 dma=0 mpu_io=0x330
opl3 io=0x388

But this is very ugly. I can't control all mixer settings, the microphone is 
not working and xmms is playing scratching noise (mpg123 is working)

What happened to the kernel? How can I use the opl3sa2 driver in kernel 2.4?

-- 
Bye, K
[a735 47ec d87b 1f15 c1e9 53d3 aa03 6173 a723 e391]
(Finger k@ailis.de to get public key)
