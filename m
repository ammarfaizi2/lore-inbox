Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265221AbSKEVjJ>; Tue, 5 Nov 2002 16:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265224AbSKEVjI>; Tue, 5 Nov 2002 16:39:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265221AbSKEVjH>;
	Tue, 5 Nov 2002 16:39:07 -0500
Message-Id: <200211052145.gA5Ljdr32055@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Nikita@Namesys.COM, reiserfs-dev@Namesys.COM, Reiserfs-List@Namesys.COM,
       Linux-Kernel@vger.kernel.org
Subject: build failure: reiser4progs-0.1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Nov 2002 13:45:39 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attempting to test reiser4, kernel 2.5.46, using the 2002.11.05 snapshot.
--------------------------------------------------
gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include -g -O2 -D_REENTRANT 
-D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -Werror 
-DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -c alloc40.c -MT alloc40.lo -MD -MP 
-MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
cc1: warnings being treated as errors
alloc40.c: In function `callback_fetch_bitmap':
alloc40.c:50: warning: signed and unsigned type in conditional expression
alloc40.c: In function `callback_flush_bitmap':
alloc40.c:209: warning: signed and unsigned type in conditional expression
alloc40.c: In function `callback_check_bitmap':
alloc40.c:376: warning: signed and unsigned type in conditional expression
make[3]: *** [alloc40.lo] Error 1
make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
oc40'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
make: *** [all] Error 2
-------------------------------------
cliffw


