Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEUGr>; Fri, 5 Jan 2001 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbRAEUGj>; Fri, 5 Jan 2001 15:06:39 -0500
Received: from jalon.able.es ([212.97.163.2]:409 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129324AbRAEUG0>;
	Fri, 5 Jan 2001 15:06:26 -0500
Date: Fri, 5 Jan 2001 21:06:16 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Module section warning
Message-ID: <20010105210616.A872@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

As linux-2.4.0/Documentation/canges says, you need:

o  binutils               2.9.1.0.25              # ld -v
o  modutils               2.4.0                   # insmod -V

and 2.4 uses gas instead of as86 for real mode.

Are not that versions enough to delete the

__asm__(".section .modinfo\n\t.previous");

in module.h ?

--

J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
