Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJMD1Q>; Sat, 12 Oct 2002 23:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSJMD1Q>; Sat, 12 Oct 2002 23:27:16 -0400
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:21764 "EHLO mail4.wi.rr.com")
	by vger.kernel.org with ESMTP id <S261415AbSJMD1P>;
	Sat, 12 Oct 2002 23:27:15 -0400
Message-ID: <001201c27269$4a4d2ee0$6400a8c0@76sdd01>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 smc-ultra transmit timeouts
Date: Sat, 12 Oct 2002 22:33:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And of course, I bother you all again.. ;) Please CC me in replies

On an older system (with a vanilla 2.4.18 kernel and the smc ultra ethernet
card on the ISA bus, no pnp) I get the following errors after modprobe'ing
the driver (smc-ultra, no options) and attempting to get a dhcp lease...
(dhcpcd)

smc-ultra.c: No SMC Ultra card found (i/o = 0x12c).
smc-ultra.c: Presently autoprobing (not recommended) for a single card.
smc-ultra.c: No ISAPnP cards found, trying standard ones...
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC Ultra at 0x300, 00 00 C0 2F FC B0, IRQ 10 memory 0xcc000-0xcffff.
eth0: interrupt from stopped card
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=410.

followed by numerous more timeout errors looking pretty similiar.  The IO
and IRQ detected are accurate, as I have it set to those via jumper.

I'm at a loss about this one... other information I can provide:
/proc/interrupts makes no mention of the smc ethernet card... The cable is
fine (link lights on router and card are on).  The BIOS of the system is a
nice simple one from 1992, so nothing about IRQ routing, etc...

...?
 - Ted

