Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279630AbRKFPYT>; Tue, 6 Nov 2001 10:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279629AbRKFPYJ>; Tue, 6 Nov 2001 10:24:09 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:53461 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S279596AbRKFPYG>; Tue, 6 Nov 2001 10:24:06 -0500
Date: Tue, 6 Nov 2001 23:23:57 +0800 (GMT-8)
From: M K Saravanan <mksarav@comp.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: undefined reference to `deactivate_page' 
Message-ID: <Pine.GSO.4.21.0111062323340.798-100000@sunA.comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while compiling kernel 2.4.14 (dated 5th Nov 2001) on a P-III machine
(under RHL7.1) i got the following err. message and the "make
bzImage" step stopped.

=============
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x8cf6): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0x8d33): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1
=============

any pointers on how to solve this problem?

-- mks --

+--------------------------==> M K Saravanan <==-------------------------+
 Research Asst.,                                mksarav@comp.nus.edu.sg
 Centre for Internet Research                   http://mksarav.tripod.com 
+---------< School of Computing, National Univ. of Singapore >-----------+




