Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTF0OIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTF0OIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:08:37 -0400
Received: from web12905.mail.yahoo.com ([216.136.174.72]:48790 "HELO
	web12905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264346AbTF0OId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:08:33 -0400
Message-ID: <20030627142247.27868.qmail@web12905.mail.yahoo.com>
Date: Fri, 27 Jun 2003 16:22:47 +0200 (CEST)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: Linux 2.5.73 - keyboard failure, repost no. 3
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030626224517.C5633@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> skrev:

> 	#define DEBUG
> 
> in
> 
> 	drivers/input/serio/i8042.c
> 
> then recompile and send me the output of that.

...
i8042.c: Detected active multiplexing controller, rev
1.1
atkbd.c: Sent: f2
atkbd.c: Recieved fe flags 00
atkbd.c: Sent: ed
atkbd.c: Recieved fe flags 00
serio: i8042 AUX0 port at 0x60,0x64 irq 12
atkbd.c: Sent: f2
atkbd.c: Recieved fe flags 00
atkbd.c: Sent: ed
atkbd.c: Recieved fe flags 00
serio: i8042 AUX1 port at 0x60,0x64 irq 12
atkbd.c: Sent: f2
atkbd.c: Recieved fa flags 00
atkbd.c: Recieved 00 flags 00
serio: i8042 AUX2 port at 0x60,0x64 irq 12
atkbd.c: Sent: f2
atkbd.c: Recieved fe flags 00
atkbd.c: Sent: ed
atkbd.c: Recieved fe flags 00
serio: i8042 AUX3 port at 0x60,0x64 irq 12
atkbd.c: Sent: f2
atkbd.c: Recieved fa flags 00
atkbd.c: Recieved ab flags 00
atkbd.c: Recieved 83 flags 00
atkbd.c: Sent: ed
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: 00
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: f8
atkbd.c: Recieved fe flags 00
atkbd.c: Sent: f4
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: f0
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: 02
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: f0
atkbd.c: Recieved fa flags 00
atkbd.c: Sent: 00
atkbd.c: Recieved fa flags 00
atkbd.c: Recieved 02 flags 00
input: AT Set 2 keyboard on isa006 0/serio0
serio: i8042 KBD port at 0x60,0x64 irq1
...

Regards,
Terje


______________________________________________________
Få den nye Yahoo! Messenger på http://no.messenger.yahoo.com/
Nye ikoner og bakgrunner, webkamera med superkvalitet og dobbelt så morsom
