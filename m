Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTF0TL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTF0TL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:11:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15512 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264651AbTF0TLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:11:54 -0400
Date: Fri, 27 Jun 2003 21:03:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?Terje_F=E5berg?= <terje_fb@yahoo.no>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73 - keyboard failure, repost no. 3
Message-ID: <20030627210346.C11454@ucw.cz>
References: <20030626224517.C5633@ucw.cz> <20030627142247.27868.qmail@web12905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030627142247.27868.qmail@web12905.mail.yahoo.com>; from terje_fb@yahoo.no on Fri, Jun 27, 2003 at 04:22:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 04:22:47PM +0200, Terje Fåberg wrote:
> Vojtech Pavlik <vojtech@suse.cz> skrev:
> 
> > 	#define DEBUG
> > 
> > in
> > 
> > 	drivers/input/serio/i8042.c
> > 
> > then recompile and send me the output of that.

When I was saying drivers/input/serio/i8042.c, I meant that. NOT
atkbd.c. Although that also does provide some info, it's not all of it.

> 
> ...
> i8042.c: Detected active multiplexing controller, rev
> 1.1
> atkbd.c: Sent: f2
> atkbd.c: Recieved fe flags 00
> atkbd.c: Sent: ed
> atkbd.c: Recieved fe flags 00
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> atkbd.c: Sent: f2
> atkbd.c: Recieved fe flags 00
> atkbd.c: Sent: ed
> atkbd.c: Recieved fe flags 00
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> atkbd.c: Sent: f2
> atkbd.c: Recieved fa flags 00
> atkbd.c: Recieved 00 flags 00
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> atkbd.c: Sent: f2
> atkbd.c: Recieved fe flags 00
> atkbd.c: Sent: ed
> atkbd.c: Recieved fe flags 00
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> atkbd.c: Sent: f2
> atkbd.c: Recieved fa flags 00
> atkbd.c: Recieved ab flags 00
> atkbd.c: Recieved 83 flags 00
> atkbd.c: Sent: ed
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: 00
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: f8
> atkbd.c: Recieved fe flags 00
> atkbd.c: Sent: f4
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: f0
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: 02
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: f0
> atkbd.c: Recieved fa flags 00
> atkbd.c: Sent: 00
> atkbd.c: Recieved fa flags 00
> atkbd.c: Recieved 02 flags 00
> input: AT Set 2 keyboard on isa006 0/serio0
> serio: i8042 KBD port at 0x60,0x64 irq1
> ...
> 
> Regards,
> Terje
> 
> 
> ______________________________________________________
> Få den nye Yahoo! Messenger på http://no.messenger.yahoo.com/
> Nye ikoner og bakgrunner, webkamera med superkvalitet og dobbelt så morsom

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
