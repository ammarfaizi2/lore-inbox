Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135817AbRAJPP7>; Wed, 10 Jan 2001 10:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135312AbRAJPPu>; Wed, 10 Jan 2001 10:15:50 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:6916 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S135801AbRAJPPh>; Wed, 10 Jan 2001 10:15:37 -0500
Date: Wed, 10 Jan 2001 17:15:35 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: EXT2-fs error in 2.4.0
Message-ID: <20010110171535.A206@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got these in 2.4.0. Sorry if it's a known problem: I haven't been following
the list very closely. This is a 100 MHz pentium and the kernel was compiled
with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release). After
booting to 2.2.latest.latest fsck did its fscking without telling anything.

Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 779318387, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600484464, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1852403827, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1801678700, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1680017961, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1852401253, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1735401573, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1818386804, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1633902437, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600481379, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1702521203, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 538976288, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1881677856, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1902081127, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1801677173, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953720684, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1735405171, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1818386804, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1633902437, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600481379, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 170490483, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1717920803, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 543518313, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1751343459, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1769168741, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 151610746, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1952935976, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1769304415, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1768713059, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 779318387, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1751343459, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 2054381413, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1107954217, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1481197140, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1162104917, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1094934342, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1881689164, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1952408948, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 539765280, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601463655, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600484464, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953718630, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1870012460, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 170484841, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1229345858, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1146115416, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1130317381, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 676088897, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 740958324, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1952802592, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1684500575, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1935763039, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1981820020, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 694446447, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1179927050, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1347770441, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1598440772, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1280065859, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1768912424, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 538979428, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1919295520, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1885300069, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1935631732, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 746024812, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1702129696, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 706770015, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1413614121, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1431849286, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1178944592, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1279345503, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1870014540, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 539780201, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1713381408, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600480626, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 2003790963, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1735401516, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 544497508, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1107962154, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1481197140, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1162104917, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1094934342, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1764248652, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 153908334, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601135648, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1667590243, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1735417707, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1633902452, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 744843363, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953392928, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1852383276, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 168438132, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1717920803, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 543518313, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601463655, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600484464, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953718630, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1109403944, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1481197140, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1130319957, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 676088897, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601463655, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600484464, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953718630, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 170469417, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1702131813, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1595960946, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1819175263, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600482921, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1836064863, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 544497508, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1952802602, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1684893791, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1935763039, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1870014580, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 170484841, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1913195131, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1920300133, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1881677934, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1952408685, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 808004128, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 175966779, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1717920803, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 543518313, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601463655, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953718630, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1109403944, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1481197140, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1130319957, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 676088897, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1601463655, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600415600, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1953718630, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 170469417, count = 1 
Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1717920803, count = 1 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
