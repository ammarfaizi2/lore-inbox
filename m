Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318993AbSHMTN0>; Tue, 13 Aug 2002 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319016AbSHMTN0>; Tue, 13 Aug 2002 15:13:26 -0400
Received: from monster.nni.com ([216.107.0.51]:20755 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318993AbSHMTNZ>;
	Tue, 13 Aug 2002 15:13:25 -0400
Date: Tue, 13 Aug 2002 15:06:18 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Subject: Mongo local_irq_foo() patch
Message-Id: <20020813150618.2d867b0e.arodland@noln.com>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd decided to run 2.5.31, and actually gotten it mostly-working when I
noticed that quite a few of my favorite modules had unresolved symbols,
mostly related to cli()/sti() and friends, so I did a semiautomatic
(completely attended) conversion of the following:

sound/oss/
drivers/net/irda/
net/irda/

The patch is rather large (111K in over 4000 lines).

Would the proper procedure be to:

split the patch up into 2 or 3 pieces and send to proper maintainers (if
I can find them),

split the patch up and send to linus+LKML,

or upload the whole thing as one big patch to HTTP and post the link
here ?

-- hobbs
