Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263966AbTIITSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTIITSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:18:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:56585 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263966AbTIITSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:18:06 -0400
Subject: Lockups when booting with CardBus NIC inserted
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1063135080.1228.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 21:18:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried jumping from 2.6.0-test4-mm6 to 2.6.0-test4-bk9. However, with
2.6.0-test4-bk9, I have noticed that I can no longer boot if my CardBus
NIC is inserted into one of the CardBus sockets. Doing so causes the
kernel to lock up hard when checking the cardbus socket. The kernel is
able to boot if the card is not inserted into the slot.

This is very similar to a previous experience I had when Russell King
was implementing a new state machine to handle the PCMCIA/CArdBus events
(and if my memory serves me well, making the number of pccardd kernel
threads equal to the number of CardBus slots).

Is anyone experiencing this?

I notified Russell King about this, but haven't heard of him since then.
I assume he is working on a fix.

Thanks!

PS: This also happens with 2.6.0-test5 and 2.6.0-test5-mm1.

