Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319029AbSIDDdP>; Tue, 3 Sep 2002 23:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319033AbSIDDdP>; Tue, 3 Sep 2002 23:33:15 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:56193 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S319029AbSIDDdO>;
	Tue, 3 Sep 2002 23:33:14 -0400
Date: Tue, 3 Sep 2002 22:26:01 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Report Status
Message-ID: <Pine.LNX.4.44.0209032223110.2336-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the followng problem report status page can be found 
at: http://members.cox.net/tmolina/kernprobs/status.html

   Notes:
     * Off-list  email sent to me regarding these reports is much 
appreciated. Relevant comments to a problem report will
       be added to the discussion thread unless specifically requested not 
to. If you do send me a comment, please CC the
       list.
     * Great  progress has been made in forward porting IDE driver code 
from 2.4 to 2.5. Several people have tried 2.5.33
       without disaster. Updates continue to be added to the -ac kernels 
and the 2.5 bitkeeper kernels.
     * Floppy  support  is  currently  semi-broken/semi-fixed  in  2.5.  
The  driver currently works (as of 2.5.33-bk) on
       filesystems  with  512-byte  blocks  (e.g. vfat/msdos) but has 
produced corruption on filesystems with other block
       sizes  such as ext2, minix, etc. Update: Several fixes to the 
floppy driver itself and the bio layer have improved
       things. This needs more testing and confirmation that the fix is 
in.
     * Support for __FUNCTION__ pasting is being phased out of gcc. This 
has broken compiling in numerous places. Defines
       of the form:
       #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " 
__FUNCTION__ "\n")
       need to be changed to the form:
       #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", 
__FUNCTION__)
     * Items  marked with "No further discussion" have not had any 
additional comments posted to the mailing list for one
       or more development point releases. These items will be archived 
when Linus issues the next point release.

               2.5 Kernel Problem Reports as of 04 Sep
   Problem Title                  Status                Discussion
   schedule() with irqs disabled! open                  03 Sep 2002
   schedule in interrupt          No further discussion 2.5.31
   JFS oops                       No further discussion 2.5.31
   unmount oops                   No further discussion 2.5.31
   usb problem                    No further discussion 2.5.31
   pte.chain BUG                  No further discussion 2.5.31
   cciss broken                   proposed fix          2.5.31
   qlogicisp oops                 open                  01 Sep 2002
   qlogic error                   No further discussion 2.5.31
   kmap_atomic oops               No further discussion 2.5.31
   swap problem                   No further discussion 2.5.31
   oops in gpm.c                  No further discussion 2.5.31
   page allocation failure        No further discussion 2.5.31
   driverfs oops                  No further discussion 2.5.31
   2.5.32 reboot oops             open                  30 Aug 2002
   ext2 umount oops               open                  30 Aug 2002
   DEBUG_SLAB oops                open                  30 Aug 2002
   2.5.32-mm1 problems            open                  30 Aug 2002
   soft suspend problem           open                  30 Aug 2002


