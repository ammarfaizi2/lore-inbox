Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBCVSn>; Sat, 3 Feb 2001 16:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130576AbRBCVSe>; Sat, 3 Feb 2001 16:18:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129225AbRBCVSY>;
	Sat, 3 Feb 2001 16:18:24 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102032112.f13LC8M19104@flint.arm.linux.org.uk>
Subject: Re: [BUG?] ISA-PnP and 3c509 NIC won't work together
To: rosenfel@informatik.hu-berlin.de (Viktor Rosenfeld)
Date: Sat, 3 Feb 2001 21:12:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A7C45E4.15C470A3@informatik.hu-berlin.de> from "Viktor Rosenfeld" at Feb 03, 2001 06:54:44 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viktor Rosenfeld writes:
> With ISA-PnP compiled in, and 3c509 support compiled as module:
> # modprobe 3c509
> /lib/modules/2.4.1/kernel/drivers/net/3c509.o: invalid parameter parm_io
> /lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod
> /lib/modules/2.4.1/kernel/drivers/net/3c509.o failed
> /lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod 3c509 failed

Silly question, but shouldn't you fix this "invalid parameter parm_io"
error first?

iirc, insmod won't insert modules when you have parameters for missing
symbols.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
