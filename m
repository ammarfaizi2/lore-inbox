Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQLUA4P>; Wed, 20 Dec 2000 19:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQLUA4G>; Wed, 20 Dec 2000 19:56:06 -0500
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:35044 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S129485AbQLUAzx>; Wed, 20 Dec 2000 19:55:53 -0500
Message-ID: <3A414DCA.A348081F@jandittmer.de>
Date: Thu, 21 Dec 2000 01:24:42 +0100
From: Jan Dittmer <jan@jandittmer.de>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: emu10k1 and 8139oo with 2.4.0test13pre3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using the emu10k1 module with my SB Live. This works quite fine, but
I cannot switch the recording channel. This worked with 2.2.17. Now
volume works, but selecting the input channel not anymore.
is anyone else experiencing this problem , or don't i just get the right
setting?

second, i habe 2 nics in my K6-2 system, both with rtl8139 chip and
compiled 8139oo into the kernel. the cards work fine, but dmesg says:

eth0: Abnormal interrupt, status 00002002
and
eth0: Abnormal interrupt, status 00000020

endless times. Usually about 2-3 entries per minute.
The cards work fine, so how can I get rid of the message, other then
uncommenting the line in the source code? This also happens if I compile
the driver as module. And happened sind 2.4.0-test12 (the first 2.4.0er
I installed).

This is my first post on this list. If you need additional information,
I'd like to provide it.

So far,

Jan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
