Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131045AbRARQUq>; Thu, 18 Jan 2001 11:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbRARQUg>; Thu, 18 Jan 2001 11:20:36 -0500
Received: from jane.hollins.EDU ([192.160.94.78]:23315 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S131045AbRARQUU>;
	Thu, 18 Jan 2001 11:20:20 -0500
Message-ID: <3A6717C0.5020209@hollins.edu>
Date: Thu, 18 Jan 2001 11:20:16 -0500
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre8 i686; en-US; m18) Gecko/20010116
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NMI Watchdog detected LOCKUP on CPU0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning my dual P2/300 with 320MB memory gave me:

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EPI:    0023:[<08076580>]
EFLAGS: 00000292
eax: fb54ba8e   ebx: bba692c5   ecx: b6fb4d53   edx: 562a18f5
esi: 216266e2   edi: 92811b25   ebp: 27cd9569   esp: 080f0148
ds: 002b   es: 002b   ss: 002b
Process dnetc (pid: 1136, stackpage=ce0f7000)
console shuts up ...

It is running 2.4.0-ac9.  I was trying to read some files NFS mounted 
from a rh6.2 machine.  (I don't know if that has anything to do with it.)

Any ideas?  None of the SAR-xx codes worked.  Reset button was necessary.

--Scott

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
