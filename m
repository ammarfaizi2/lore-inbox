Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269291AbRGaNlw>; Tue, 31 Jul 2001 09:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269296AbRGaNlo>; Tue, 31 Jul 2001 09:41:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269291AbRGaNle>; Tue, 31 Jul 2001 09:41:34 -0400
Date: Tue, 31 Jul 2001 09:41:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Controlling Terminal
Message-ID: <Pine.LNX.3.95.1010731093430.18329A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Sorry about off-topic, but how do I create a "controlling
terminal" for a process. I know how to open the device,
dup it to 0, 1, 2, set up signals, etc. However, the
shell (bash) won't allow job-control, and ^C kills bash
instead of what it's executing.

I'm trying to run a shell off a multiplexed RF link. I've
got a good clean 8-bit link. I should not have to use
a pty. The driver's output "looks" like a terminal so it
should be able to be a controlling terminal.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


