Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271466AbRHZTGz>; Sun, 26 Aug 2001 15:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271467AbRHZTGp>; Sun, 26 Aug 2001 15:06:45 -0400
Received: from qn-212-127-164-130.quicknet.nl ([212.127.164.130]:53263 "EHLO
	mail.loesberg.com") by vger.kernel.org with ESMTP
	id <S271466AbRHZTGb>; Sun, 26 Aug 2001 15:06:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcel Loesberg <mhll@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: Problem with module esssolo1.o
Date: Sun, 26 Aug 2001 22:00:20 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01082622002001.00938@sharkie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not a kernel developer and I have no idea where I should send this 
request to. I hope you can forward it to the right person/list.
Please also ask if he/she/they can "Cc:" me on the discussion because I'm not
a member of the list.

My problem:

When I try to compile and install the esssolo1.o module I get the following
error after typing "make modules_install".

depmod: *** Unresolved symbols in 
/lib/modules/2.4.8/kernel/drivers/sound/esssolo1.o
depmod:         gameport_register_port
depmod:         gameport_unregister_port

I tried this with kernel 2.4.8 and 2.4.9
My system is a IBM Thinkpad 390e (the version with a Celeron CPU).
The sound card is a ESS Solo 1 that is build into the laptop.
The laptop/soundcard doesn't have a gameport.
With the kernel that ships with RedHat Linux 7.1 (2.4.2-2) the soundcard does
work.

I hope you can tell me how I can get it working with the latest kernel.

With kind regards,

Marcel Loesberg
