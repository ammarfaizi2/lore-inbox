Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbQLSXjV>; Tue, 19 Dec 2000 18:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbQLSXjM>; Tue, 19 Dec 2000 18:39:12 -0500
Received: from feral.com ([192.67.166.1]:19024 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S130219AbQLSXjA>;
	Tue, 19 Dec 2000 18:39:00 -0500
Date: Tue, 19 Dec 2000 15:08:28 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [ PATCH ] against 2.4.0-test13-pre3 - fixes builds for ALPHA
Message-ID: <Pine.LNX.4.21.0012191506520.7545-100000@zeppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm. Gotta build setup-*.c somehow. Alpha Config defines ALPHA_FOO (Generic or
specific model #) but not vanilla alpha.


--- linux.orig/arch/alpha/config.in	Tue Dec 19 14:54:14 2000
+++ linux/arch/alpha/config.in	Tue Dec 19 14:53:05 2000
@@ -4,6 +4,7 @@
 #
 
 define_bool CONFIG_UID16 n
+define_bool CONFIG_ALPHA y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
