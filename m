Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbQLIXEP>; Sat, 9 Dec 2000 18:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbQLIXEF>; Sat, 9 Dec 2000 18:04:05 -0500
Received: from ozob.net ([216.131.4.130]:385 "EHLO ozob.net")
	by vger.kernel.org with ESMTP id <S129849AbQLIXEA>;
	Sat, 9 Dec 2000 18:04:00 -0500
Date: Sat, 9 Dec 2000 16:33:32 -0600 (CST)
From: ebi4 <ebi4@ozob.net>
Reply-To: ebi4 <ebi4@ozob.net>
To: linux-kernel@vger.kernel.org
Subject: parport0 problem
In-Reply-To: <E1442DQ-0002VT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001209162326.3937C-100000@ozob.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't print and I found this in the logs:

Dec  9 16:10:49 ozob kernel: parport0: Nibble timeout at event 9 (0 bytes) 
Dec  9 16:11:29 ozob last message repeated 4 times
Dec  9 16:12:39 ozob last message repeated 7 times
Dec  9 16:13:40 ozob last message repeated 6 times

If I reboot, then I can print for a while and then this repeats.

Can anyone tell me what this means and what to do about it?

kernel: 2.4.0-test12-pre7 (same problem with pre3)
cpu: intel 686
printer: hp4500
kernel setup:
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

CONFIG_PRINTER=y

I can supply any information necessary.

Thanks,

::::: Gene Imes			     http://www.ozob.net :::::


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
