Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312584AbSDSRfG>; Fri, 19 Apr 2002 13:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSDSRfF>; Fri, 19 Apr 2002 13:35:05 -0400
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:13317 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S312584AbSDSRfF>;
	Fri, 19 Apr 2002 13:35:05 -0400
Date: Fri, 19 Apr 2002 19:35:26 +0200
From: Frank de Lange <lkml-frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: severe slowdown with 2.4 series w/heavy disk access (revisited)
Message-ID: <20020419193507.A17439@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

Anyone remember this thread:

   "severe slowdown with 2.4 series w/heavy disk access"

   http://hypermail.spyroid.com/linux-kernel/archived/2001/week52/0266.html

It describes the tendency of 2.4 series kernels to slowdown under I/O load.
Well, that problem still seems to be alive and kicking. And no, it is not
related to reiserfs as I previously suggested in this thread:

   "Abysmal interactive performance on 2.4.linus", archived here:

   http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0911.html

I removed the last reiserfs partition quite some time ago, currently running
mostly ext3 with ext2 root fs.

The systems use IDE disks, I don't have any SCSI-systems handy to test whether
this might be IDE-only (anyone?). Currently running 2.4.18 (with preempt and
lowlatency, but the problems are NOT related to those patches as they also hit
unpatched kernels) on SMP (Abit BP-6 yeah yeah I know but it does not seem to
be specific to the BP-6).

Does anyone else see these problems? Specifically, does anyone with a
SCSI-based system see this happening? Also, does anyone who uses only ext2 (no
ext3 or reiserfs, let alone jfs/xfs or any other journaling fs) see this?

Cheers//Frank

 [ BTW: I'm moving to Sweden, and am looking for a project/job in Västra
   Götaland, preferrably Göteborg... Anyone know anything interesting? ]
-- 
  WWWWW      ________________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  \ `--| _/     <Hacker for Hire>      \
   `---'  \                            /
           \ lkml-frank@unternet.org  /
            `------------------------'
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
