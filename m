Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTEKKJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTEKKJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:09:05 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:20946 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261195AbTEKKJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:09:01 -0400
Message-ID: <3EBE2436.80504@POGGS.CO.UK>
Date: Sun, 11 May 2003 11:21:42 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: Xose Vazquez Perez <xose@wanadoo.es>
Subject: Re: PATCH: Trivial, pedantic spelling mistakes for 2.4.21-rc2
References: <3EBDAB7F.4000905@wanadoo.es>
In-Reply-To: <3EBDAB7F.4000905@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xose Vazquez Perez wrote:

>>A patch to correct some misspellings in 2.4.21-rc2 is at
>>http://journal.poggs.com/2003/05/10/spell-2.4.21rc2.patch.gz.
>>    
>>
>The requested URL /2003/05/10/spell-2.4.21rc2.patch.gz was not found on this server.
>
Oops, I forgot to gzip it... what was I on yesterday?!

>would you mind put a patch without compress and sent it to linux-kernel?
>  
>
Here's the diff:

*** SNIP ***

diff -ru linux-2.4.21-rc2.orig/arch/alpha/kernel/sys_marvel.c 
linux-2.4.21-rc2/arch/alpha/kernel/sys_marvel.c
--- linux-2.4.21-rc2.orig/arch/alpha/kernel/sys_marvel.c        
2003-05-10 15:17:30.000000000 +0100
+++ linux-2.4.21-rc2/arch/alpha/kernel/sys_marvel.c     2003-05-10 
15:00:18.000000000 +0100
@@ -222,7 +222,7 @@
         */
        val = io7->csrs->PO7_LSI_CTL[which].csr;
        val &= ~(0x1ffUL << 14);                /* clear the target pid */
-       val |= ((unsigned long)where << 14);    /* set teh new target pid */
+       val |= ((unsigned long)where << 14);    /* set the new target pid */

        io7->csrs->PO7_LSI_CTL[which].csr = val;
        mb();
@@ -239,7 +239,7 @@
         */
        val = io7->csrs->PO7_MSI_CTL[which].csr;
        val &= ~(0x1ffUL << 14);                /* clear the target pid */
-       val |= ((unsigned long)where << 14);    /* set teh new target pid */
+       val |= ((unsigned long)where << 14);    /* set the new target pid */

        io7->csrs->PO7_MSI_CTL[which].csr = val;
        mb();
diff -ru linux-2.4.21-rc2.orig/arch/ia64/sn/io/io.c 
linux-2.4.21-rc2/arch/ia64/sn/io/io.c
--- linux-2.4.21-rc2.orig/arch/ia64/sn/io/io.c  2003-05-10 
15:17:32.000000000 +0100
+++ linux-2.4.21-rc2/arch/ia64/sn/io/io.c       2003-05-10 
15:00:41.000000000 +0100
@@ -631,7 +631,7 @@
 }

 /*
- * Check that an address is in teh real small window widget 0 space
+ * Check that an address is in the real small window widget 0 space
  * or else in the big window we're using to emulate small window 0
  * in the kernel.
  */
@@ -708,7 +708,7 @@
 /*
  * hub_setup_prb(nasid, prbnum, credits, conveyor)
  *
- *     Put a PRB into fire-and-forget mode if conveyor isn't set.  
Otehrwise,
+ *     Put a PRB into fire-and-forget mode if conveyor isn't set.  
Otherwise,
  *     put it into conveyor belt mode with the specified number of credits.
  */
 void
diff -ru linux-2.4.21-rc2.orig/drivers/char/rio/rioctrl.c 
linux-2.4.21-rc2/drivers/char/rio/rioctrl.c
--- linux-2.4.21-rc2.orig/drivers/char/rio/rioctrl.c    2001-04-14 
04:26:07.000000000 +0100
+++ linux-2.4.21-rc2/drivers/char/rio/rioctrl.c 2003-05-10 
15:01:01.000000000 +0100
@@ -203,7 +203,7 @@

        func_enter ();

-       /* Confuse teh compiler to think that we've initialized these */
+       /* Confuse the compiler to think that we've initialized these */
        Host=0;
        PortP = NULL;

diff -ru linux-2.4.21-rc2.orig/drivers/s390/block/dasd_3990_erp.c 
linux-2.4.21-rc2/drivers/s390/block/dasd_3990_erp.c
--- linux-2.4.21-rc2.orig/drivers/s390/block/dasd_3990_erp.c    
2003-05-10 15:17:38.000000000 +0100
+++ linux-2.4.21-rc2/drivers/s390/block/dasd_3990_erp.c 2003-05-10 
15:02:21.000000000 +0100
@@ -2809,7 +2809,7 @@
  *     - exit with permanent error
  *
  * PARAMETER
- *   erp                ERP which is in progress wiht no retry left
+ *   erp                ERP which is in progress with no retry left
  *
  * RETURN VALUES
  *   erp                modified/additional ERP
diff -ru linux-2.4.21-rc2.orig/drivers/scsi/cpqfcTSstructs.h 
linux-2.4.21-rc2/drivers/scsi/cpqfcTSstructs.h
--- linux-2.4.21-rc2.orig/drivers/scsi/cpqfcTSstructs.h 2003-05-10 
15:17:39.000000000 +0100
+++ linux-2.4.21-rc2/drivers/scsi/cpqfcTSstructs.h      2003-05-10 
15:05:47.000000000 +0100
@@ -93,7 +93,7 @@
 #define CPQFCTS_CMD_PER_LUN    15      // power of 2 -1, must be >0
 #define CPQFCTS_REQ_QUEUE_LEN  (TACH_SEST_LEN/2)       // must be < 
TACH_SEST_LEN

-/* FIMXME - these are crpa too */
+/* FIMXME - these are crap too */
 #define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
 #ifndef DECLARE_MUTEX_LOCKED
 #define DECLARE_MUTEX_LOCKED(sem) struct semaphore sem = MUTEX_LOCKED
diff -ru linux-2.4.21-rc2.orig/include/asm-ia64/sn/router.h 
linux-2.4.21-rc2/include/asm-ia64/sn/router.h
--- linux-2.4.21-rc2.orig/include/asm-ia64/sn/router.h  2002-08-03 
01:39:45.000000000 +0100
+++ linux-2.4.21-rc2/include/asm-ia64/sn/router.h       2003-05-10 
15:01:14.000000000 +0100
@@ -500,7 +500,7 @@

        /*
         * Everything below here is for kernel use only and may change at
-        * at any time with or without a change in teh revision number
+        * at any time with or without a change in the revision number
         *
         * Any pointers or things that come and go with DEBUG must go at
         * the bottom of the structure, below the user stuff.
diff -ru linux-2.4.21-rc2.orig/include/linux/reiserfs_fs.h 
linux-2.4.21-rc2/include/linux/reiserfs_fs.h
--- linux-2.4.21-rc2.orig/include/linux/reiserfs_fs.h   2003-05-10 
15:17:44.000000000 +0100
+++ linux-2.4.21-rc2/include/linux/reiserfs_fs.h        2003-05-10 
15:01:56.000000000 +0100
@@ -129,7 +129,7 @@
 /* the spot for the super in versions 3.5 - 3.5.10 (inclusive) */
 #define REISERFS_OLD_DISK_OFFSET_IN_BYTES (8 * 1024)

-// reiserfs internal error code (used by search_by_key adn fix_nodes))
+// reiserfs internal error code (used by search_by_key and fix_nodes))
 #define CARRY_ON      0
 #define REPEAT_SEARCH -1
 #define IO_ERROR      -2

*** SNIP ***



Peter.

