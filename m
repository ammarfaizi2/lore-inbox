Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTIAOvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTIAOvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:51:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14863 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262903AbTIAOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:51:53 -0400
Date: Mon, 1 Sep 2003 15:51:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Jamie Lokier <jamie@shareable.org>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901155150.B22682@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901151710.A22682@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Sep 01, 2003 at 03:17:10PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the results for a SA1110 machine (ie, with non-broken
write buffer):

Linux assabet2 2.6.0-test4 #1313 Thu Aug 28 21:05:05 BST 2003 armv4l unknown

Processor       : StrongARM-1110 rev 8 (v4l)
BogoMIPS        : 147.04
Features        : swp half 26bit fastmult 
CPU implementer : 0x69
CPU architecture: 4
CPU variant     : 0x0
CPU part        : 0xb11
CPU revision    : 8

Hardware        : Intel-Assabet
Revision        : 0000
Serial          : 0000000000000000

(64) [21,6,1] Test separation: 4096 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 8192 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 16384 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 32768 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 65536 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 131072 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 262144 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 524288 bytes: FAIL - too slow
(64) [21,7,1] Test separation: 1048576 bytes: FAIL - too slow
(64) [21,7,1] Test separation: 2097152 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 4194304 bytes: FAIL - too slow
(64) [21,6,1] Test separation: 8388608 bytes: FAIL - too slow
(64) [21,7,1] Test separation: 16777216 bytes: FAIL - too slow
VM page alias coherency test: failed; will use copy buffers instead


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

