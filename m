Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272651AbTHKOxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272739AbTHKOwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:52:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:1738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272686AbTHKOu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:50:27 -0400
Message-Id: <200308111450.h7BEoOu20077@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [OSDL] linux-2.6.0-test3 reaim results
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_120757360"
Date: Mon, 11 Aug 2003 07:50:24 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 -mm5 4/8 cpu runs are with AS and Nick Piggin patch.

Host: STP 1-CPU

Reaim test results

#  STP id PLM#  Kernel Name               Workfile  MaxJPM MaxUser Host PCT
 1 277453 2049 linux-2.6.0-test3         new_dbase  1020.72     17 stp1-001 0.00
 2 277302 2043 2.6.0-test2-mm5           new_dbase  983.73     17 stp1-001 -3.62
 6 276782 2020 linux-2.6.0-test2         new_dbase  1008.42     17 stp1-001 -1.21
Host: STP 2-CPU

Reaim test results

#  STP id PLM#  Kernel Name               Workfile  MaxJPM MaxUser Host PCT
 1 277454 2049 linux-2.6.0-test3         new_dbase  1337.64     22 stp2-001 0.00
 2 277303 2043 2.6.0-test2-mm5           new_dbase  1333.34     22 stp2-002 -0.32
14 276572 2020 linux-2.6.0-test2         new_dbase  1320.68     22 stp2-000 -1.27
Host: STP 4-CPU

Reaim test results

#  STP id PLM#  Kernel Name               Workfile  MaxJPM MaxUser Host PCT
 1 277455 2049 linux-2.6.0-test3         new_dbase  5324.95     92 stp4-000 0.00
1 277315 2047 as-mm5-fix2               new_dbase  5138.56     68 stp4-003 -3.50
10 277206 2020 linux-2.6.0-test2         new_dbase  5430.43     92 stp4-000 1.98
Host: STP 8-CPU

Reaim test results

#  STP id PLM#  Kernel Name               Workfile  MaxJPM MaxUser Host PCT
 1 277456 2049 linux-2.6.0-test3         new_dbase  8954.12    144 stp8-002 0.00
 1 277446 2047 as-mm5-fix2               new_dbase  8244.85    104 stp8-002 -7.90
 3 276570 2020 linux-2.6.0-test2         new_dbase  8938.54    144 stp8-002 -0.17


---------------
Detail on any run:
http://khack.osdl.org/stp/<STP id> 
Hardware details:
http://khack.osdl.org/stp/<STP id>/environment/machine_info
More results:
http://developer.osdl.org/cliffw/reaim/index.html
---------------

Code location:
bk://developer.osdl.org/osdl-aim-7
tarball:
http://sourceforge.net/projects/re-aim-7

Run parameters:

./reaim -s$CPU_COUNT -x -t -i$CPU_COUNT -f workfile.new_dbase -r3 -b -l./stp.config
./reaim -s$CPU_COUNT -q -t -i$CPU_COUNT -f workfile.new_dbase -r3 -b -l./stp.config
(3 runs each, average of all 6 reported) 

cliffw



