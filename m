Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbRCXQy6>; Sat, 24 Mar 2001 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbRCXQyt>; Sat, 24 Mar 2001 11:54:49 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:55104 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131710AbRCXQye>;
	Sat, 24 Mar 2001 11:54:34 -0500
Message-ID: <3ABCD0B2.21465AC1@sgi.com>
Date: Sat, 24 Mar 2001 08:52:02 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NCR53c8xx driver and multiple controllers...(not new prob)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with 3 of these controllers (a 4 CPU server).  The
3 controllers are:
ncr53c810a-0: rev=0x23, base=0xfa101000, io_port=0x2000, irq=58
ncr53c810a-0: ID 7, Fast-10, Parity Checking
ncr53c896-1: rev=0x01, base=0xfe004000, io_port=0x3000, irq=57
ncr53c896-1: ID 7, Fast-40, Parity Checking
ncr53c896-2: rev=0x01, base=0xfe004400, io_port=0x3400, irq=56
ncr53c896-2: ID 7, Fast-40, Parity Checking
ncr53c896-2: on-chip RAM at 0xfe002000

I'd like to be able to make a kernel with the driver compiled in and
no loadable module support.  It don't see how to do this from the
documentation -- it seems to require a separate module loaded for
each controller.  When I compile it in, it only see the 1st controller
and the boot partition I think is on the 3rd.  Any ideas?

This problem is present in the 2.2.x series as well as 2.4.x (x up to 2).

Thanks,
-linda
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
