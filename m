Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSAZVrt>; Sat, 26 Jan 2002 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSAZVrj>; Sat, 26 Jan 2002 16:47:39 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:51339 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S287106AbSAZVrZ>; Sat, 26 Jan 2002 16:47:25 -0500
From: "Chris Mason" <chris@bash.sh>
To: <linux-kernel@vger.kernel.org>
Subject: SPARCstation 5 (sun4m) and 2.4.17
Date: Sat, 26 Jan 2002 21:48:07 -0000
Message-ID: <000401c1a6b3$24bac020$0100a8c0@krad>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know I have seen this discussed before on various mailing lists, but
it was generally regarding the 2.4.0-test kernels.  I am attempting to
use 2.4.17 on a SPARCstation 5 (sun4m) with 192MB of RAM.

On attempting to boot the kernel I get the following message;

SILO boot:
PROMLIB: obio_ranges 1
bootmem_init: Scan sp_banks,
init_bootmem(spfn[41ad],bpfn[4a1d],mlpfn[c000])

It then pauses for a period of about 3 mins then I get the following (as
expected),

Watchdog Reset, Rebooting.
Resetting ...

I have attempted to pass it mem=16M as some earlier posts suggested to
do on 2.4.0-test kernels with no luck.  On enable PROM_DEBUG_CONSOLE in
/usr/src/linux/arch/sparc/kernel/setup.c I see that the kernel does
oops, however as the screen moves up very quickly I cannot read what it
is saying.

Thanks in advance,
Chris

