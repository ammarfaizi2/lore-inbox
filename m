Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971379-3797>; Wed, 29 Jul 1998 08:51:41 -0400
Received: from Morgane.OLEANE.Net ([194.2.1.9]:1433 "EHLO morgane.oleane.net" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <971396-3797>; Wed, 29 Jul 1998 08:50:44 -0400
Message-Id: <199807291434.QAA00194@gr.opengroup.org>
X-Mailer: exmh version 2.0zeta 7/24/97
From: Eric PAIRE <e.paire@opengroup.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.rutgers.edu (Linux Kernel), Eric PAIRE <e.paire@opengroup.org>
Subject: 2.1.111 fix for debugger ptrace(PTRACE_ATTACH, ...) side-effects
Reply-To: Eric PAIRE <e.paire@opengroup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Jul 1998 16:34:58 +0200
Sender: owner-linux-kernel@vger.rutgers.edu


Hi Linus,

As part of my development of gdb for multithreaded applications, I have
found bugs in the way the Linux kernel manages processes dynamicly attached
by a debugger.

The summary of the bugs, the SMP-safe fix explanation and the patch file
are all available at http://www.gr.opengroup.org/java/jdk/linux/kernel1.htm

Best regards,
-Eric
P.S. The patch file contains the fix against a clean 2.1.111
P.S.2 I have just seen that the 2.1.112 is out (and that a cleaner 2.1.113
	is about to be available :-) If you want me to adapt the fix for
	2.1.113 and test it on my 4-way SMP, just let me know. Right now,
	it works correctly on 2.1.111.
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+ Eric PAIRE
Email : e.paire@gr.opengroup.org  | THE Open GROUP - Grenoble Research 
Institute
Phone : +33 (0) 476 63 48 71 	  | 2, avenue de Vignate
Fax   : +33 (0) 476 51 05 32	  | F-38610 Gieres      FRANCE



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
