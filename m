Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135977AbRDTTx6>; Fri, 20 Apr 2001 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDTTxs>; Fri, 20 Apr 2001 15:53:48 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:58548 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136005AbRDTTxc>; Fri, 20 Apr 2001 15:53:32 -0400
Date: Fri, 20 Apr 2001 21:53:30 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: rwsem.o listed twice as export-objs
Message-ID: <20010420215330.N682@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

please remove rwsem.o from the list of exported objects, if it is
not used.

Regards

Ingo Oeser

patch is as follows

--- lib/Makefile.orig   Fri Apr 20 21:51:12 2001
+++ lib/Makefile        Fri Apr 20 21:51:19 2001
@@ -8,7 +8,7 @@

 L_TARGET := lib.a

-export-objs := cmdline.o rwsem.o
+export-objs := cmdline.o

 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o

-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
