Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131008AbQKJOcP>; Fri, 10 Nov 2000 09:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQKJOb7>; Fri, 10 Nov 2000 09:31:59 -0500
Received: from wg.redhat.de ([193.103.254.4]:60752 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S131008AbQKJObm>;
	Fri, 10 Nov 2000 09:31:42 -0500
Date: Fri, 10 Nov 2000 15:31:40 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: linux-kernel@vger.kernel.org
Subject: APIC errors w/ 2.4.0-test11-pre2
Message-ID: <Pine.LNX.4.21.0011101523170.14596-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after booting a 2.4.0 (any testx-release I've tried so far, including
test11-pre2) on a Dual-Pentium III box, the system works ok, but the
console gets filled with

APIC error on CPU0: 08(08)

every couple of seconds, occasionally some lines in between say

APIC error on CPU0: 08(02)

and

APIC error on CPU0: 02(08)

This doesn't happen with 2.2.x, but I've seen "unexpected IRQ vector 208
on CPU0" in 2.2.18 occasionally (nowhere near as often, maybe once a
month).

This is an ASUS P2-D board (Intel 440BX chipset), 2 Pentium III-700
processors.

The same kernel works perfectly on a similar (but slower) system, Gigabyte
P2B-D board (Intel 440BX chipset), 2 Pentium III-450 processors.

LLaP
bero


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
