Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269553AbRHAAOU>; Tue, 31 Jul 2001 20:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269554AbRHAAOK>; Tue, 31 Jul 2001 20:14:10 -0400
Received: from beauty.binarix.com ([203.41.202.9]:3332 "EHLO
	beauty.binarix.com") by vger.kernel.org with ESMTP
	id <S269553AbRHAANw>; Tue, 31 Jul 2001 20:13:52 -0400
Message-ID: <3B6749ED.7E0E6E2D@binarix.com>
Date: Wed, 01 Aug 2001 10:14:37 +1000
From: Bojan Smojver <bojan@binarix.com>
Organization: Binarix Corporation Pty Ltd
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ftape: kernel panic
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I've discovered this purely by accident but it happened to me twice
already and on different kernels (2.2.x) and 2.4.7. The drive in
question is Seagate 8 GB internal ATAPI drive. I have had it on an Intel
VX430 chipset motherboard, kernel 2.2.x and now I have on an SiS 5571
chipset motherboard, running 2.4.7.

The problem occurs whey I attempted (by mistake) to write QTR-1 tape in
a Travan 4 drive. The kernel panics. When attempting to read the QTR-1
tape, an error about getting too much data starts occurring and then
there is 'lost interrupt' message as well. This doesn't cause kernel
panic. Writing/reading 8 GB cartridges is perfectly fine.

It is very easy to replicate the problem (happens every time) by doing
the above. I used tar to write to the tape.

This is not necessarily very important, but it might save someone a few
headaches when they insert QTR-1 tape into a Travan 4 drive by mistake
or on purpose. Especially if the machine is otherwise important and is
not supposed to be rebooted :-)

Bojan

PS. Bojan's Law: "All tape cartridges look the same at 6:30 am".
