Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAIVJW>; Tue, 9 Jan 2001 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRAIVJM>; Tue, 9 Jan 2001 16:09:12 -0500
Received: from ns.sysgo.de ([213.68.67.98]:1783 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129573AbRAIVJF>;
	Tue, 9 Jan 2001 16:09:05 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: Anybody got 2.4.0 running on a 386 ?
Date: Tue, 9 Jan 2001 21:53:21 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010922090000.02630@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
The kernel was built for a 386 Processor, Math emulation has been enabled.
I tried three different 386 boards. Execution seems to get as far as
pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
if someone had pressed the reset button. The same kernel boots fine on
486 and Pentium Systems.

Any ideas/suggestions ?

Rob

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
