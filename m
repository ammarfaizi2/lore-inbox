Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264648AbSKFKQw>; Wed, 6 Nov 2002 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264707AbSKFKQw>; Wed, 6 Nov 2002 05:16:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11022 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264648AbSKFKQv>; Wed, 6 Nov 2002 05:16:51 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.60827.825112.148774@laputa.namesys.com>
Date: Wed, 6 Nov 2002 13:23:23 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Cliff White <cliffw@osdl.org>
Cc: reiserfs-dev@Namesys.COM, Reiserfs-List@Namesys.COM,
       Linux-Kernel@vger.kernel.org
Subject: Re: build failure: reiser4progs-0.1.0
In-Reply-To: <200211052145.gA5Ljdr32055@mail.osdl.org>
References: <200211052145.gA5Ljdr32055@mail.osdl.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Tom-Swifty: "Care for some `suan la chow show'?" Tom asked wantonly.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White writes:
 > 
 > Attempting to test reiser4, kernel 2.5.46, using the 2002.11.05 snapshot.

Can you please try "./configure --enable-Werror=no --without-readline"
as workaround?

 > --------------------------------------------------
 > gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include -g -O2 -D_REENTRANT 
 > -D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -Werror 
 > -DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -c alloc40.c -MT alloc40.lo -MD -MP 
 > -MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
 > cc1: warnings being treated as errors
 > alloc40.c: In function `callback_fetch_bitmap':
 > alloc40.c:50: warning: signed and unsigned type in conditional expression
 > alloc40.c: In function `callback_flush_bitmap':
 > alloc40.c:209: warning: signed and unsigned type in conditional expression
 > alloc40.c: In function `callback_check_bitmap':
 > alloc40.c:376: warning: signed and unsigned type in conditional expression
 > make[3]: *** [alloc40.lo] Error 1
 > make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
 > oc40'
 > make[2]: *** [all-recursive] Error 1
 > make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
 > make[1]: *** [all-recursive] Error 1
 > make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
 > make: *** [all] Error 2
 > -------------------------------------
 > cliffw

Nikita.

 > 
 > 
