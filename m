Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBJAA3>; Fri, 9 Feb 2001 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBJAAT>; Fri, 9 Feb 2001 19:00:19 -0500
Received: from jalon.able.es ([212.97.163.2]:54431 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129107AbRBJAAA>;
	Fri, 9 Feb 2001 19:00:00 -0500
Date: Sat, 10 Feb 2001 00:59:52 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kaos@ocs.com.au
Subject: ksymoops versioning
Message-ID: <20010210005952.C959@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

Just a little mismatch in versions.
ksymoops packaged as 2.4.0 still says it is version 2.3.7:

werewolf:~/soft/kernel/ksymoops-2.4.0# ./ksymoops -V
ksymoops 2.3.7 on i686 2.4.1-ac9.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac9/ (default)
     -m /usr/src/linux/System.map (default)

???

Just to check, also downloaded ksymoops-2.3.6, and look:

werewolf:~/soft/kernel/ksymoops-2.3.6# ./ksymoops -V
ksymoops 2.3.5 on i686 2.4.1-ac9.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac9/ (default)
     -m /usr/src/linux/System.map (default)

What's the matter with versions ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac8 #2 SMP Fri Feb 9 01:53:46 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
