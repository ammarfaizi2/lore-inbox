Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHKRdM>; Sun, 11 Aug 2002 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSHKRdM>; Sun, 11 Aug 2002 13:33:12 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:52487 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315919AbSHKRc7>;
	Sun, 11 Aug 2002 13:32:59 -0400
Date: Sun, 11 Aug 2002 13:28:27 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.31 : fs/intermezzo/vfs.c compile error
Message-ID: <Pine.LNX.4.44.0208111327080.13320-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 While 'make modules', I received the following error:
Regards,
Frank

vfs.c: In function `presto_debug_fail_blkdev':
vfs.c:134: invalid initializer
vfs.c:136: warning: implicit declaration of function `is_read_only'
vfs.c: In function `presto_do_rmdir':
vfs.c:1244: warning: implicit declaration of function `double_down'
vfs.c:1260: warning: implicit declaration of function `double_up'
vfs.c: In function `presto_rename_dir':
vfs.c:1627: warning: implicit declaration of function `triple_down'
vfs.c:1644: warning: implicit declaration of function `triple_up'
vfs.c: In function `lento_do_rename':
vfs.c:1755: warning: implicit declaration of function `double_lock'
make[2]: *** [vfs.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [fs] Error 2

