Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276341AbRJPOvr>; Tue, 16 Oct 2001 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRJPOv1>; Tue, 16 Oct 2001 10:51:27 -0400
Received: from smtp.seznam.cz ([195.119.180.43]:65032 "HELO email.seznam.cz")
	by vger.kernel.org with SMTP id <S276341AbRJPOvQ>;
	Tue, 16 Oct 2001 10:51:16 -0400
Message-ID: <001101c15652$5dadc1e0$5365060a@franta>
From: "Frantisek Dufka" <dufkaf@seznam.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Wake-up from APM suspend state by /dev/rtc ?
Date: Tue, 16 Oct 2001 16:53:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

I wanted to record my favourite Simpsons series from TV via my ATI TV wonder
card. It works fine automatically, no X needed, just framebuffer
(nuppelvideo 0.4, nuv2divx, v4lctl from xawtv). I wanted to have my machine
suspended when waiting for the recording to spare some trees.

There is setting in a bios for turning on interrupts which should cause
wake-up. I turned interrupt 8 on. I modified code from
linux/Documentation/rtc.txt To set alarm to some time. Then I tried 'apm -S'
or 'apm -s' and waited.
Unfortunately it doesn't work. When I wake it up by mouse later, the
modified code from rtc.txt gets the interrupt and finishes fine. But it
doesn't wake up itself by RTC interrupt :(

I also tried to turn on kernel compile flag which enables interrupts when
calling APM bios but it didn't help.

I suppose it's a bios bug, so probably I can't do anything with it.

Anyone tried this successfully? Should it work? Can using ACPI instead of
APM help me with this?

I've got Soyo 6VBA133 motherboard (Slot1) with VIA Apollo 133 chipset,
Celeron 900. Kernel 2.4.12.

Thanks for any helpful reply.

Frantisek


