Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131595AbQK3LTz>; Thu, 30 Nov 2000 06:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132827AbQK3LTp>; Thu, 30 Nov 2000 06:19:45 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:24851 "HELO
        smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
        id <S131595AbQK3LT1>; Thu, 30 Nov 2000 06:19:27 -0500
X-Apparently-From: <kernelcoder@yahoo.com>
Message-ID: <3A262417.8984F476@yahoo.com>
Date: Thu, 30 Nov 2000 15:25:35 +0530
From: Archan Paul <kernelcoder@yahoo.com>
Reply-To: kernelcoder@yahoo.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: alan@redhat.com
Subject: trident module in 2.2.17-21 crashes for Ali5451
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have the following soundcard in my ToshibaDynabook(db45) model of
laptop.

Acer Laboratories Inc. [ALi]|M5451 PCI South Bridge Audio
(MULTIMEDIA_AUDIO unknown) SubVendor=0x1179 SubDevice=0x0003

Till the date, I was using 2.2.16kernel typically compiled for RH7. To
enable the sound card, I was doing the following
	modprobe soundcore
	modprobe soundlow
	modprobe sound
	modprobe ac97_codec
	modprobe trident
This worked fine.

But I am facing problem from the time, I have upgraded the m/c to
2.2.17-21 kernel in Mandrake7.2 Whenever I am doing the above, m/c
hangs. I tried to use the natively compiled code of trident in 2.2.17
kernel, but again, the kernel freezes while booting. I have not tested
the trident driver for 2.4 kernel. Can anyone please help me??

Archan

--
--------------------------------------
Archan Paul (enlightened by GNU/Linux)
www.bigfoot.com/~archanp
icq 61737056
--------------------------------------


__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
