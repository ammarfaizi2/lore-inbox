Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSKLMGQ>; Tue, 12 Nov 2002 07:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbSKLMGQ>; Tue, 12 Nov 2002 07:06:16 -0500
Received: from projecti.gemsoft.co.uk ([195.10.224.46]:4224 "EHLO r2d2.office")
	by vger.kernel.org with ESMTP id <S266520AbSKLMGP>;
	Tue, 12 Nov 2002 07:06:15 -0500
Message-ID: <3DD0F03F.9000604@walrond.org>
Date: Tue, 12 Nov 2002 12:12:47 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 serial driver bug with asus pr-dls m/b
References: <3DB84EAB.5020608@walrond.org> <20021103135813.B5589@flint.arm.linux.org.uk> <3DD0E95D.3090801@walrond.org>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hold on. Don't worry about this for a minute; I've just discovered some 
stuff which I'll confirm and post later.

Andrew Walrond wrote:

> Sorry for delay in reply.
>
> Anyway, with vanilla 2.5.47 (which already has your attached patch it 
> seems) and DEBUG_AUTOCONF enabled as you suggest
>
> 1) With second serial port *disabled* in bios, I get
>
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0: autoconf (0x03f8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> ttyS1: autoconf (0x02f8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> ttyS2: autoconf (0x03e8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> ttyS3: autoconf (0x02e8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> pnp: the driver 'serial' has been registered
>
> 2) With second serial port *enabled* in bios, I get
>
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0: autoconf (0x03f8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> ttyS1: autoconf (0x02f8, 0x00000000): iir=3 iir1=6 iir2=6 type=16550A
> tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS2: autoconf (0x03e8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> ttyS3: autoconf (0x02e8, 0x00000000): IER test failed (ff, ff) 
> type=unknown
> pnp: the driver 'serial' has been registered
>
> Hope this helps; Let me know if I can do anything else; Now settled 
> into my new office so can turn around any tests immediately.
>
> Andrew Walrond
>
>


