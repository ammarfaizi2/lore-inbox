Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132308AbQKWMpV>; Thu, 23 Nov 2000 07:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132352AbQKWMpL>; Thu, 23 Nov 2000 07:45:11 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:9894 "EHLO
        old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
        id <S132308AbQKWMo6>; Thu, 23 Nov 2000 07:44:58 -0500
Message-ID: <3A1CFC1C.305C5C1E@ftel.co.uk>
Date: Thu, 23 Nov 2000 11:14:36 +0000
From: Paul Flinders <P.Flinders@ftel.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: becker@scyld.com
CC: linux-kernel@vger.kernel.org
Subject: Problems with DFE-550 & Sundance driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sundance driver in 2.4.0-test11 doesn't seem to like a DFE-550
that I have

On module installation te driver identifies the card but cant  find any
PHYs, also if I remove the module afterwards I can't reinsert it.

Any suggestions?

The messages are

On installation:
eth0: OEM Sundance Technology ST201 at 0xca858000, 00:50:ba:02:95:70, IRQ 11.
eth0: No MII transceiver found!, ASIC status 62

On re-installation
/lib/modules/2.4.0-test11/kernel/drivers/net/sundance.o: init_module: No such device
Using /lib/modules/2.4.0-test11/kernel/drivers/net/sundance.o
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
