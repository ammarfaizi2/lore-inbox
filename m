Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280897AbRKOPVP>; Thu, 15 Nov 2001 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKOPVF>; Thu, 15 Nov 2001 10:21:05 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:16391 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S280897AbRKOPUw>; Thu, 15 Nov 2001 10:20:52 -0500
Message-ID: <03f301c16de9$8b751c00$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Russell King" <rmk@arm.linux.org.uk>, <jgarzik@mandrakesoft.com>
Cc: <tytso@mit.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <20011115001016.C19575@flint.arm.linux.org.uk>
Subject: Re: Fw: [Patch] Some updates to serial-5.05
Date: Thu, 15 Nov 2001 10:23:57 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Russell King" <rmk@arm.linux.org.uk>
> I've merged the simple bits of this by hand with my serial CVS.  As I
> said in a previous mail here, I'm not taking on the maintainence of the
> existing serial.c driver.  Therefore, these comments apply to the
> new serial driver, not the existing drivers.

Copied to you because I thought you might be interested in adding
some of them to the new driver.

> These two I'd rather waited until we've got the driver merged into 2.5,
> at which point I'd rather have a patch against the new driver.

Fair enough.

> I don't actually printk() the serial ports that have been discovered at
> boot time in the new serial CVS.  If people scream enough, I could be
> persuaded.  I'm currently of the opinion that they're noise, and if
> we're really interested in them, we've got a userspace tool to do it
> for us: setserial -bg /dev/ttyS*

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> I'll complain ;-)   It seems pretty standard for a driver to print out
> at least one single line for each "interface" it registers; interface in

I agree with Jeff.

> Only the MULTISERIAL support applied - 2.4 has the PCI class definitions,
> so when the new driver is merged, we already have the definitions.

serial_compat.h has more than just missing pci #defs. Although
I suppose you wouldn't need it in the new driver if backwards
compatability isn't being preserved. Compatability of the new driver
with old kernels that is.

..Stu


