Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbSJBWMw>; Wed, 2 Oct 2002 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbSJBWMw>; Wed, 2 Oct 2002 18:12:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56797 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262651AbSJBWMv>; Wed, 2 Oct 2002 18:12:51 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210022218.g92MIIY22253@devserv.devel.redhat.com>
Subject: Linux 2.5.40-ac1
To: linux-kernel@vger.kernel.org
Date: Wed, 2 Oct 2002 18:18:18 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux 2.5.40-ac1

+	Initial port of aacraid driver to 2.5		(me)
+	vfat corruption fix				(Petr Vandrovec)
+	Clean up firestream warnings			(Francois Romieu)
+	Voyager support					(James Bottomley)
+	Fix split_vma					(Hugh Dickins)
+	Fix config in video subdirectory		(John Levon)
+	Update olympic driver to 2.5			(Mike Phillips)
+	Fix sg init error				(Mike Anderson)
+	Fix Rules.make
o	Merge most of ucLinux stuff			(Greg Ungerer)
	| It needs putting somewhere so we can pick over the
	| hard bits left
	| Q: Wouldn't drivers/char/mem-nommu.c be better
	| Q: How to do the procfs stuff tidily
	| Q: Wouldn't it be nicer to move all mm or mmnommu specific ksyms
	|    int the relevant mm/*.c file area instead of kernel/ksyms
	| Q: Why ifdef out overcommit -  its even easier to account on 
	|    MMUless and useful info
+	Stick tulip back under 10/100 ethernet		(me)
+	Correct docs for IBM touchpad back to how	(me)
	they were before
o	Fix abuse of set_bit in winbond-840		(me)
+	Fix abuse of set_bit in atp			(me)

--
	"When Dilbert has a better working environment than you
			its time to leave"
				- Anonymous
