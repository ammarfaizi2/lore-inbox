Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbRGYXAO>; Wed, 25 Jul 2001 19:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbRGYXAF>; Wed, 25 Jul 2001 19:00:05 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:10643 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S267317AbRGYW7u>;
	Wed, 25 Jul 2001 18:59:50 -0400
Message-ID: <3B5F4FCA.EF860FF@dawa.demon.co.uk>
Date: Thu, 26 Jul 2001 00:01:30 +0100
From: Paul Flinders <paul@dawa.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE "lost interrupt" on SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I decided to replace the Celerons on my Asus P2B-D with something
a little faster so I bought a new 1Ghz PIII** (it would have been two but
the local dealer only had one in stock).

However I can't boot any SMP configured kernel. It gets as far as
the partition check and then starts printing "hd<x>: lost interrupt"
after than it proceeds _very_ slowly to print the partitions and
then grinds to a halt as it tries to mount the root fs (I suspect that
it hasn't actually crashed but that disk I/O is proceeding extremely
slowly).

Configuring the kernel for single processor works and boots OK
- this is true for all the kernels (2.2.x and 2.4.x including 2.4.7)
that I've tried.

I thought that SMP kernels were OK with just one processor. Do
I need to add the second one or could there be something else
wrong.

** Actually underclocked at 750Mhz as the BX chipset only goes to
100 Mhz FSB

