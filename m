Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKJEOD>; Thu, 9 Nov 2000 23:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKJENx>; Thu, 9 Nov 2000 23:13:53 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:13042 "EHLO
	mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S129100AbQKJENl>; Thu, 9 Nov 2000 23:13:41 -0500
Message-ID: <3A0B8881.F444DF5@home.com>
Date: Fri, 10 Nov 2000 00:32:49 -0500
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test11-pre2 compile error undefined reference to `bust_spinlocks'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

When attempting to compile test11-pre2, I get the following compile
error.

arch/i386/mm/mm.o: In function `do_page_fault':
arch/i386/mm/mm.o(.text+0x781): undefined reference to `bust_spinlocks'
make: *** [vmlinux] Error 1

John Kacur
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
