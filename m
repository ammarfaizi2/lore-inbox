Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAIG7O>; Tue, 9 Jan 2001 01:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIG7E>; Tue, 9 Jan 2001 01:59:04 -0500
Received: from ppp-225.cust210-9-18.ghr.chariot.net.au ([210.9.18.225]:34569
	"EHLO mars.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S129267AbRAIG6t>; Tue, 9 Jan 2001 01:58:49 -0500
To: linux-kernel@vger.kernel.org
cc: pschulz@foursticks.com.au
Subject: [Announcement] kgdb - unofficial (untested) patch available for 2.4.0
Date: Tue, 09 Jan 2001 17:26:11 +1030
From: Paul Schulz <pschulz@foursticks.com.au>
Message-Id: <E14FshX-00064D-00@mars.foursticks.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who are interested..

I have taken the kgdb patch for 2.4.0-test9 and ported it to 2.4.0.
This is a minimal patch, and doesn't include any of the documentation
or supporting programmes. It can be found at:

http://www.foursticks.com.au/~pschulz/kgdb
http://www.foursticks.com.au/~pschulz/kgdb/linux-2.4.0-kgdb.patch

There is also a patch for 2.4.0-test12

http://www.foursticks.com.au/~pschulz/kgdb/linux-2.4.0-test12-kgdb.patch

For more information see...

http://kgdb.sourceforge.net

kgdb is a patch to the linux kernel. It allows use of gdb for source level
debugging of a linux kernel. One can place breakpoints, step through code
and observe variables in the kernel similar to debugging a program.

For using kgdb you need two machines. One of these machines is the development
machine and the other is tests machine. The kernel to be debugged runs
on the tests machine. gdb runs on the development machine. The machines
are connected through a serial line. The serial line is used by gdb to
communicate to the kernel being debugged.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
