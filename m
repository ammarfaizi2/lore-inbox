Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136554AbRAJVYc>; Wed, 10 Jan 2001 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJVYV>; Wed, 10 Jan 2001 16:24:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37542 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129406AbRAJVYL>; Wed, 10 Jan 2001 16:24:11 -0500
Date: Wed, 10 Jan 2001 16:23:29 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0 and "LSR safety check engaged!\n"
Message-ID: <Pine.LNX.4.31.0101101614400.12952-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the subject message when trying to initiate a PPP connection over
an internal USR 56k/flex modem defined as /dev/ttyS0.

It happens with both diald and chat(from PPP).

The "LSR safety check engaged!\n" message then causes this (diald):
diald[407]: failed to get initial modem terminal attributes: Input/output error
diald[407]: could not get initial terminal attributes: Input/output error
diald[407]: failed to set terminal attributes: Input/output error
chat[803]: Can't get terminal parameters: Input/output error

The serial support at boot is:
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

Any clues ?  This is keeping me at 2.2.19prex for the nonce.

Thanks,
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
