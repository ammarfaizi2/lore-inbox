Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbTCNMze>; Fri, 14 Mar 2003 07:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbTCNMze>; Fri, 14 Mar 2003 07:55:34 -0500
Received: from eldar.tcsn.co.za ([196.41.199.50]:23569 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id <S261533AbTCNMzd>;
	Fri, 14 Mar 2003 07:55:33 -0500
Date: Fri, 14 Mar 2003 15:06:18 +0200
From: Henti Smith <bain@tcsn.co.za>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: missing linux/gdb.h in 2.5.64-mm6 kernel
Message-Id: <20030314150618.3a61ae0d.bain@tcsn.co.za>
Organization: The Computer Smith Networks
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all 

I'm not having success compiling 2.5.64-mm6. 
I compile standard linux-2.5.64 but after applying 2.5.64-mm6
I get this 

init/main.c:48:23: linux/gdb.h: No such file or directory
init/main.c: In function `start_kernel':
init/main.c:457: `gdb_enter' undeclared (first use in this function)
init/main.c:457: (Each undeclared identifier is reported only once
init/main.c:457: for each function it appears in.)
init/main.c:458: warning: implicit declaration of function `gdb_hook'

Also make clean gives me this: (worked before applying patch)

scripts/Makefile.clean:10: drivers/scsi/isp/Makefile: No such file or directory
make[3]: *** No rule to make target `drivers/scsi/isp/Makefile'.  Stop.
make[2]: *** [drivers/scsi/isp] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [_clean_drivers] Error 2

I checked with kernel debugging and without.

I located linux/gdb.h in a directory called 25/ one branch up parellel to the patched linux tree.

I've checked on the list .. and pretty much anywhere I can find .. 

Maybe I'm just missing something really obvios .. 

any suggestions ? 

Henti Smith
