Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132408AbQK3Az3>; Wed, 29 Nov 2000 19:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132436AbQK3AzT>; Wed, 29 Nov 2000 19:55:19 -0500
Received: from io.frii.com ([216.17.128.3]:50948 "EHLO io.frii.com")
        by vger.kernel.org with ESMTP id <S132408AbQK3AzL>;
        Wed, 29 Nov 2000 19:55:11 -0500
Date: Wed, 29 Nov 2000 17:24:44 -0700
From: Nicholas Dronen <ndronen@frii.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/sysrq.txt: How to scroll back on console.
Message-ID: <20001129172444.A24830@frii.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This might be useful to add to Documentation/sysrq.txt.

Regards,

Nick 

--- sysrq.txt.orig      Wed Nov 29 17:13:18 2000
+++ sysrq.txt   Wed Nov 29 17:23:33 2000
@@ -21,7 +21,10 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 On x86   - You press the key combo 'ALT-SysRQ-<command key>'. Note - Some
            (older?) may not have a key labeled 'SysRQ'. The 'SysRQ' key is
-           also known as the 'Print Screen' key.
+           also known as the 'Print Screen' key.  To scroll back (as
+           you often need to do to view all of the output of some
+           SysRQ commands), simply press shift-pageup.  (I only know
+           this to work on x86.  It might work elsewhere as well.)

 On SPARC - You press 'ALT-STOP-<command key>', I believe.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
