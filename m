Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUDEVvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbUDEVt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:49:27 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:26809 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263366AbUDEVsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:48:33 -0400
Date: Tue, 6 Apr 2004 07:51:42 +1000
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       a.nielsen@optushome.com.au
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-Id: <20040406075142.147a0e4c.a.nielsen@optushome.com.au>
In-Reply-To: <20040404111513.A3165@electric-eye.fr.zoreil.com>
References: <406EA054.2020401@colorfullife.com>
	<20040404105558.2bffd4f0.malvineous@optushome.com.au>
	<20040404111513.A3165@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you send the unpatched r8169.o module ?

Here is the compiled source file (r8169.c -> r8169.o) from 2.6.5-rc1
(which had the same problem and has an identical .c file) but I'm not
sure if it's different to the final module so please let me know if you
wanted something else:

http://members.optushome.com.au/a.nielsen/r8169.o.bz2  (66 kB)

Cheers,
Adam.

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-slackware-linux/3.2.3/specs
Configured with: ../gcc-3.2.3/configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-__cxa_atexit --disable-checking
--with-gnu-ld --verbose --target=i486-slackware-linux
--host=i486-slackware-linux
Thread model: posix
gcc version 3.2.3
