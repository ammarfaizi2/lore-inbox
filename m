Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129485AbQKWAcY>; Wed, 22 Nov 2000 19:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129682AbQKWAcD>; Wed, 22 Nov 2000 19:32:03 -0500
Received: from jalon.able.es ([212.97.163.2]:34704 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S129485AbQKWAb5>;
        Wed, 22 Nov 2000 19:31:57 -0500
Date: Thu, 23 Nov 2000 01:01:45 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: uname
Message-ID: <20001123010145.A744@werewolf.able.es>
Reply-To: jamagallon@able.es
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

Little question about 'uname'. Does it read data from kernel, /proc or
get its data from other source ?

uname info page:
$ uname -a
Linux hayley 1.0.4 #3 Thu May 12 18:06:34 1994 i486

my system:

uname -a
Linux werewolf 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

uname -m (machine)
i686

uname -p (processor)
unknown

Seems like swapping machine-processor.
Perhaps it can be changed to uname -m give the info in get_cpu_vendor(),
and uname -p give the ix86.
Or if some utility relays on uname -m being ix86, make uname -p give cpu_vendor+
cpu_model.

--
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
