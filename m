Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269246AbSIRWNF>; Wed, 18 Sep 2002 18:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbSIRWNF>; Wed, 18 Sep 2002 18:13:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:62725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269246AbSIRWNE>;
	Wed, 18 Sep 2002 18:13:04 -0400
Message-Id: <200209182218.g8IMI7R07353@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: stp-devel@lists.sourceforge.net
Subject: [OSDL] Contest 0.34 added to STP - 2.4.20-pre5-ac1 results
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Sep 2002 15:18:06 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to Con and everyone for making this necessary.
The contest (http://contest.kolivas.net) has been added to 
the OSDL Scalable Test Platform. (http://www.osdl.org/stp) 

Sample results for a 2- cpu system with 2.4.20-pre5-ac1
Test 		Time(sec)	CPU %	Ratio 
noload		61.95		195%	baseline 
process_load	69.45		170%	1.12l 
io_halfmem	67.86		179%	1.10l 
io_fullmem	100.57		121%	1.62l 
mem_load	96.06		129%	1.55l
Results for a single-CPU system ( 2.4.20-pre5-ac1 )
noload		104.65		99%	baseline 
process_load	116.80		88%	1.12l 
io_halfmem	117.81		89%	1.13l 
io_fullmem	128.72		82%	1.23l 
mem_load	143.17		77%	1.37l
Full report: http://khack.osdl.org/stp/5235/ ( 2-cpu)
http://khack.osdl.org/stp/5234/		     ( 1-cpu)


Would very much appreciate your comments. One note: 
The '-j' value is adjusted = number of cpu's * 4 
However, the background load is the same regardless of system size.
Should the load be scaled with the system? 
( say, one copy of each load program per cpu? ) 

Also, our friendly PLM now automagically inhales the -ac series
(i think...i see 2.4.20-pre5-ac[1-6] plus a few more ) 


cliffw

