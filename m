Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTIDUc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIDUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:32:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:15757 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262105AbTIDUbV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:31:21 -0400
From: Michael Schierl <schierlm-usenet@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: laptop touchpad on linux-2.6.0-test4
Date: Thu, 04 Sep 2003 22:30:12 +0200
Reply-To: schierlm@gmx.de
References: <rauV.61c.9@gated-at.bofh.it> <raEA.6jw.17@gated-at.bofh.it>
In-Reply-To: <raEA.6jw.17@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S262105AbTIDUbV/20030904203206Z+914@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Sep 2003 06:10:12 +0200, in linux.kernel you wrote:

>http://geocities.com/dt_or/gpm/gpm.html for updated version of GPM

Hmm, I downloaded gpm-1.20.1, unpacked it, applied the patches (tried
it both with the cumulative one and with the single ones), ran

autoconf && ./configure && make

and got:

[...]
gcc -I/usr/src/gpm/gpm-1.20.1/src -DHAVE_CONFIG_H -include
headers/config.h -Wall -DSYSCONFDIR="\"/usr/local/etc\""
-DSBINDIR="\"/usr/local/sbin\""  -g -O2  -c -o prog/mouse-test.o
prog/mouse-test.c
prog/mouse-test.c: In function `main':
prog/mouse-test.c:285: parse error before `struct'
prog/mouse-test.c:337: `opt' undeclared (first use in this function)
prog/mouse-test.c:337: (Each undeclared identifier is reported only
once
prog/mouse-test.c:337: for each function it appears in.)
prog/mouse-test.c:394: `mdev' undeclared (first use in this function)
prog/mouse-test.c:553: warning: value computed is not used
prog/mouse-test.c:606: warning: value computed is not used
prog/mouse-test.c:655: warning: value computed is not used
make[1]: *** [prog/mouse-test.o] Error 1
make[1]: Leaving directory `/usr/src/gpm/gpm-1.20.1/src'
make: *** [do-all] Error 1

Any ideas what I did wrong?

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
