Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSIKBzk>; Tue, 10 Sep 2002 21:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSIKBzk>; Tue, 10 Sep 2002 21:55:40 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:6784 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318275AbSIKBzi>;
	Tue, 10 Sep 2002 21:55:38 -0400
Date: Tue, 10 Sep 2002 21:00:30 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Status Report
Message-ID: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The most current version of this status report can be found at:
http://members.cox.net/tmolina/kernprobs/status.html

   Notes:
     * Several  people  have  requested  the  discussion be linked to LKML 
archives. With this version I've switched from
       locally edited discussion threads to archived links.
     * Great  progress has been made in forward porting IDE driver code 
from 2.4 to 2.5. Several people have tried 2.5.33
       without disaster. Updates continue to be added to the -ac kernels 
and the 2.5 bitkeeper kernels.
     * Floppy  support  appears to have been fixed in 2.5.33-bitkeeper. It 
has been tested, and the corruption previously
       seen has not been duplicated.
     * Support for __FUNCTION__ pasting is being phased out of gcc. This 
has broken compiling in numerous places. Defines
       of the form:
       #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " 
__FUNCTION__ "\n")
       need to be changed to the form:
       #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", 
__FUNCTION__)

              2.5 Kernel Problem Reports as of 10 Sep
   Problem Title                Status                Discussion
   JFS oops                     open                  06 Sep 2002
   qlogicisp oops               no further discussion 2.5.33
   2.5.32 reboot oops           no further discussion 2.5.33
   ext2 umount oops             no further discussion 2.5.33
   DEBUG_SLAB oops              no further discussion 2.5.33
   2.5.32-mm1 problems          no further discussion 2.5.33
   soft suspend problem         no further discussion 2.5.33
   PCI and/or starfire.c broken no further discussion 2.5.33
   __write_lock_failed() oops   no further discussion 2.5.33
   invalidate_inode_pages       open                  10 Sep 2002
   Problem running on Athlons   open                  06 Sep 2002
   dequeue_signal panic                               08 Sep 2002
                                closed                09 Sep 2002
   mouse/keyboard flakiness     open                  09 Sep 2002
   process hang in do_IRQ       open                  09 Sep 2002
   do_syslog lockup             open                  09 Sep 2002
   BUG at kernel/sched.c        open                  10 Sep 2002


