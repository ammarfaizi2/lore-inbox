Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTEaSBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTEaSBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:01:38 -0400
Received: from BELLINI.MIT.EDU ([18.62.3.197]:16132 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id S264393AbTEaSBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:01:37 -0400
Date: Sat, 31 May 2003 14:15:16 -0400 (EDT)
From: ghugh Song <ghugh@bellini.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Something wrong with recent 2.4.21-rc* kernels?
Message-ID: <Pine.LNX.4.53.0305311354230.2743@bellini.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am comparing

2.4.21-pre3-ac4
2.4.21-rc5-ac1
2.4.21-rc6-ac1

In the last two kernels, something is definitely not right.
LaTeXing a big file takes about twice the time compared to
the same job under 2.4.21-pre3-ac4.
However, I am not totally satisfied with the 2.4.21-pre3-ac4, either.
In the beginning just after a reboot, the condition is really nice.
However, after a while, "time"ing a job reveals that something bad is
happening in the first column of "real" time, which means the wall-clock
timing.  One might say that it is still better with 2.4.21-pre3-ac4
than the situation with 2.4.21-rc5-ac1 or with 2.4.21-rc6-ac1, because
it still does not contaminate "user" time in the middle column.

With 2.4.21-pre3-ac4, as everyone comlained, there seems to be a
problem with the cursor movement while kernel-compilation in the back.
The mouse movement seemed to have improved in 2.4.21-rc6-ac1.  But
overall performance hit is just not acceptable.

BTW, the .config file for 2.4.21-rc6-ac1 has been taken from
2.4.21-pre3-ac4 during compilation.

The motherboard is an Asus with the Nvidia2 chipset.
Main system is running off SCSI hard disks under Adaptec U2-SCSI PCI
controller.  No ATAPI hard disk is running at the moment.
I never used the installed ATAPI CDrom during the test.

In the emaillist, I have been reading about random halts in recent
kernels, i.e., 2.4.21-rc*.  Well. I did not experience such a
drastic things. maybe because I did not wait long enough.

Regards,

G. Hugh Song



