Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266046AbRGGGPG>; Sat, 7 Jul 2001 02:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRGGGOz>; Sat, 7 Jul 2001 02:14:55 -0400
Received: from munk.apl.washington.edu ([128.95.96.184]:52110 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S266046AbRGGGOg>; Sat, 7 Jul 2001 02:14:36 -0400
Date: Fri, 6 Jul 2001 23:04:28 -0700 (PDT)
From: Brian Dushaw <dushaw@apl.washington.edu>
To: <linux-kernel@vger.kernel.org>
cc: Brian Dushaw <dushaw@apl.washington.edu>,
        Mike Wolfson <wolfson@apl.washington.edu>
Subject: ASUS CUV4X-D Dual CPU's - Failure to boot...
Message-ID: <Pine.LNX.4.33.0107062244260.3175-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel People,
   A friend of mine has a new PC with an ASUS CUV4X-D motherboard
and dual 1GHZ PIII's.  We have installed RedHat 7.1.  The original
RedHat SMP kernel (2.4.2) did not boot; it froze with some complaints
about APIC.  The backup single processor kernel 2.4.2 booted o.k.,
however.   The upgraded kernel from RedHat (2.4.3) also refused to boot
properly - the boot up will start and the screen will then go blank
before I can discern any informative messages.  I also downloaded the
latest 2.4.6 kernel which had the identical problem, and then I also
applied the latest Alan-Cox patch for 2.4.6 which did not solve the
problem.  The 2.4.6 kernel will boot when only a single processor
is used, however.
   The system is fairly basic - no sound card, ADAPTEC SCSI card (nothing
attached for now), 1 GB PC133 RAM, 2 60 GB IDE Harddrives (1 Maxtor, 1 IBM),
CD and CDRW, GeFORCE 2 MX video card, 3Com 3c59x ethernet and not much else.
   Specs for the motherboard are at:
http://www.asus.com.tw/Products/Motherboard/pentiumpro/cuv4x-d/index.html

   Any idea as to how we might get the dual processors to work?  My next plan
is to compile the kernel without the Pentium III optimizations...

Thanks,
B.D.
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

