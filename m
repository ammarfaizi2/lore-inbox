Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbQLPLNG>; Sat, 16 Dec 2000 06:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPLMz>; Sat, 16 Dec 2000 06:12:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:29961 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131309AbQLPLMn>;
	Sat, 16 Dec 2000 06:12:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jon Akers <jka@ufbi.ufl.edu>
cc: "'Kernel Mailing List '" <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling test13-pre2 
In-Reply-To: Your message of "Sat, 16 Dec 2000 00:24:01 CDT."
             <4504FB4A84EFD31196070050DA7E89D003BD15@admin-serv.ufbi.ufl.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 21:42:04 +1100
Message-ID: <14752.976963324@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000 00:24:01 -0500, 
Jon Akers <jka@ufbi.ufl.edu> wrote:
>This appears to be a problem with the Makefile changes and NFS/NFSD/lockd
>and module compilation.

Index: 0-test13-pre2.1/fs/lockd/svc.c
--- 0-test13-pre2.1/fs/lockd/svc.c Mon, 02 Oct 2000 15:28:44 +1100 kaos (linux-2.4/e/b/39_svc.c 1.1.1.2 644)
+++ 0-test13-pre2.1(w)/fs/lockd/svc.c Sat, 16 Dec 2000 21:26:35 +1100 kaos (linux-2.4/e/b/39_svc.c 1.1.1.2 644)
@@ -312,7 +312,6 @@ out:
 #ifdef MODULE
 /* New module support in 2.1.18 */
 
-EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_DESCRIPTION("NFS file locking service version " LOCKD_VERSION ".");
 MODULE_PARM(nlm_grace_period, "10-240l");


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
