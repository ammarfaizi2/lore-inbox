Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSIWSV4>; Mon, 23 Sep 2002 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSIWSV4>; Mon, 23 Sep 2002 14:21:56 -0400
Received: from [62.67.222.139] ([62.67.222.139]:14018 "EHLO kermit")
	by vger.kernel.org with ESMTP id <S261295AbSIWSVz>;
	Mon, 23 Sep 2002 14:21:55 -0400
Date: Mon, 23 Sep 2002 20:00:18 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7-ac3 aic7xxx broken?
Message-ID: <20020923180017.GA16270@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Kletschke & Uhlig GbR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I wonder if my 

Bus  0, device   9, function  0:
      SCSI storage controller: Adaptec AHA-7850 (rev 3).
        IRQ 11.
        Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
        I/O at 0xa000 [0xa0ff].
        Non-prefetchable 32 bit memory at 0xe7001000 [0xe7001fff].

is broken or the aic7xxx driver in linux-2.4.20-pre7-ac3?

The modul loads fine, the cdrom seems to work properly, though,
but this messages appears in my
message.log:

==> /var/log/syslog <==
Sep 23 19:32:23 sexmachine kernel: scsi1: PCI error Interrupt at seqaddr
= 0x9
Sep 23 19:32:23 sexmachine kernel: scsi1: Data Parity Error Detected
during address or write data phase

several times a minute. The aic7xxx_old produces no errorr messages...

Konsti


-- 
Kletschke & Uhlig GbR: 
http://www.ku-gbr.de
