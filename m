Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbTCJIZq>; Mon, 10 Mar 2003 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbTCJIZq>; Mon, 10 Mar 2003 03:25:46 -0500
Received: from mail-3.nethere.net ([66.63.128.72]:19730 "HELO
	mail-3.nethere.net") by vger.kernel.org with SMTP
	id <S262745AbTCJIZp>; Mon, 10 Mar 2003 03:25:45 -0500
To: linux-kernel@vger.kernel.org
Subject: IRQ conflicts - unsolvable???
Message-ID: <1047285385.3e6c4e8912cd3@webmail.nethere.net>
Date: Mon, 10 Mar 2003 00:36:25 -0800 (PST)
From: mikemohr@nethere.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.8
X-Originating-IP: 207.167.100.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost; I did not see my original message get
through, perhaps due to an MTA issue on my host. I apologize
if this is a duplicate - please resend any replies, as I could
not find those either. I am subscribed.

------------------------------

Hello:

Thanks all for providing a wonderful operating system for me
to use free of charge. I can't believe that you guys do all
this work for free, you are simply amazing. I would like to
contribute to the kernel once I learn more C, but alas not
yet.. anyhow, here is the reason I am writing to you:

I have major problems with PnP onboard hardware. I can get it
all working, but the problem is that some of it doesn't like
sharing IRQs. Especially my sound card. The sound card times
out at random times when I am playing music, say with XMMS.
My secondary ethernet card also conflicts with the card on
IRQ7. I have tried everything I can think of, resettings the
ESCD, set all H/W to auto, and played with BIOS settings for 2
weeks.

The only way I can see to fix this problem is to change a few
settings in my BIOS and reboot, kind of point and shoot and
hope it hits... as you can imagine, this takes a _long_ time.
This is the best config possible so far:

mohr@rosetta:~$ cat /proc/interrupts
CPU0
0: 2547713 XT-PIC timer
1: 739 XT-PIC keyboard
2: 0 XT-PIC cascade
4: 1969066 XT-PIC usb-ohci, nvidia, serial
7: 723591 XT-PIC NVIDIA nForce Audio, ehci-hcd
8: 1 XT-PIC rtc
11: 56868 XT-PIC usb-ohci, ohci1394, eth0
12: 14465 XT-PIC PS/2 Mouse
14: 154253 XT-PIC ide0
15: 5 XT-PIC ide1
NMI: 0
LOC: 2547675
ERR: 98
mohr@rosetta:~$


Please tell me there is a solution! I need help :) I don't
want to be stuck like a pig on Windows!

Thanks
Michael
