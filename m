Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUBWQIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUBWQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:08:35 -0500
Received: from eri.interia.pl ([217.74.65.138]:9995 "EHLO eri.interia.pl")
	by vger.kernel.org with ESMTP id S261940AbUBWQFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:05:48 -0500
Date: Mon, 23 Feb 2004 17:05:15 +0100
From: Jakub Panachida <void@poczta.fm>
To: linux-kernel@vger.kernel.org
Subject: gcc-3.3.3 syntax changed
Message-Id: <20040223170515.7e878ff0.void@poczta.fm>
Organization: Battlefield
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Incompability of linux-2.6.3 header files with gcc-3.3.3

Full Description:
gcc-3.3.3 doesn't allow syntax used in files asm/byteorder.h and
linux/byteorder/swab.h, which is included by the previous one.

Keywords:
gcc-3.3.3

Environment:
Linux xenon.pl 2.6.3-2 #1 Sun Feb 22 16:10:08 CET 2004 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.0
Modules Loaded

Kernel version:
Linux version 2.6.3-2 (void@xenon.pl) (gcc version 3.3.3) #1 Sun Feb 22
16:10:08 CET 2004

Sample code:
#include <asm/byteorder.h>

Error Message:
/usr/include/asm/byteorder.h:14: error: syntax error before "__u32"
/usr/include/asm/byteorder.h:28: error: syntax error before "__u64"
In file included from /usr/include/linux/byteorder/little_endian.h:11,
                 from /usr/include/asm/byteorder.h:57,
                 from k26.c:1:
/usr/include/linux/byteorder/swab.h:133: error: syntax error before "__u16"
/usr/include/linux/byteorder/swab.h:146: error: syntax error before "__u32"
/usr/include/linux/byteorder/swab.h:160: error: syntax error before "__u64"


-- 
Jakub Panachida

