Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132081AbRAASRB>; Mon, 1 Jan 2001 13:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAASQm>; Mon, 1 Jan 2001 13:16:42 -0500
Received: from d134.as12.nwbl0.wi.voyager.net ([169.207.136.136]:10500 "EHLO
	giuseppe") by vger.kernel.org with ESMTP id <S132081AbRAASQ1>;
	Mon, 1 Jan 2001 13:16:27 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre compile err (pcxx)
From: apgarcia@uwm.edu (A. P. Garcia)
Date: 01 Jan 2001 17:43:28 +0000
Message-ID: <87snn3f9rz.fsf@uwm.edu>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when i make bzimage with the pc/xx driver configured as a module, it
compiles ok.  configuring it as built-in gives the following error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-prerelease/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o pcxx.o pcxx.c
pcxx.c: In function `pcxxdelay':
pcxx.c:1826: `mseconds' undeclared (first use in this function)
pcxx.c:1826: (Each undeclared identifier is reported only once
pcxx.c:1826: for each function it appears in.)
make[3]: *** [pcxx.o] Error 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
