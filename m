Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284726AbRLZShG>; Wed, 26 Dec 2001 13:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbRLZSg4>; Wed, 26 Dec 2001 13:36:56 -0500
Received: from colorfullife.com ([216.156.138.34]:28934 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284726AbRLZSgs>;
	Wed, 26 Dec 2001 13:36:48 -0500
Message-ID: <002f01c18e3c$493bead0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <toxischerabflussreiniger@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: writing device drivers for commercial hardware
Date: Wed, 26 Dec 2001 19:36:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd start with:

- read the existing smartcard drivers
- check the windows driver - there is software that monitors the serial port and logs all calls.
http://www.sysinternals.com/ntw2k/freeware/portmon.shtml
Try to reverse engineer the protocol between the driver and the smartcard reader.
- open the smartcard reader, and check if you can identify the producer of the ICs that are used. Then try to find the datasheet.
google often helps.
- Ask the company that makes the smartcard reader - perhaps they'll help you?

I'm not sure if the driver should be user space or kernel space, but I'd definitively start in userspace.

Good luck,
--
    Manfred


