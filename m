Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRCMBJr>; Mon, 12 Mar 2001 20:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130698AbRCMBJi>; Mon, 12 Mar 2001 20:09:38 -0500
Received: from [208.49.193.203] ([208.49.193.203]:6409 "EHLO web.kd0yu.com")
	by vger.kernel.org with ESMTP id <S129764AbRCMBJV>;
	Mon, 12 Mar 2001 20:09:21 -0500
Message-Id: <200103130108.f2D18YO08079@goliath.kd0yu.com>
Date: Mon, 12 Mar 2001 19:08:31 -0600 (CST)
From: dave@kd0yu.com
Reply-To: dave@kd0yu.com
Subject: aicasm build error with db3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi group,

  I recently seen a message go by regarding this....
Sorry for asking if this has been hashed out more than twice.
I didn't see anything in Documentation about it.  Nothing in
Configure.help about db3 either.

make[4]: Entering directory `/usr/src/linux-2.4.2/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
/tmp/cc4xDUrp.o: In function `symtable_open':
/tmp/cc4xDUrp.o(.text+0x1b5): undefined reference to `__db185_open'
collect2: ld returned 1 exit status
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.2/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.2/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2/drivers'
make: *** [_mod_drivers] Error 2


I have verified the path in aicdb.h is correct.
I am attempting to build it as a module to include in an initrd.

Tnx
-- 
Dave

---------------------------------------------------------------------------
Dave Helton, KD0YU    - dave@realworldcomputing.net  - http://www.kd0yu.com
Real World Computing  - 319-386-4041                 - 8am-5pm CST    
---------------------------------------------------------------------------


