Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290674AbSBFQrT>; Wed, 6 Feb 2002 11:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSBFQrK>; Wed, 6 Feb 2002 11:47:10 -0500
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:34310 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S290665AbSBFQrA>; Wed, 6 Feb 2002 11:47:00 -0500
Subject: Toshiba CD-RW/DVD doesn't work after Suspend/Resume
From: Tom Sightler <ttsig@tuxyturvy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 06 Feb 2002 11:46:51 -0500
Message-Id: <1013014015.1396.66.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been struggling trying to get my Dell C810 to suspend/resume
properly with APM.  I have almost everything working except for one very
annoying problem that I'm hoping someone might help me with.  

The machine has a built-in Toshiba CD-RW/DVD drive and after a
suspend/resume cycle the first access to the drive will lock the machine
solid.  The hard disk access light stays on solid and I can't get
anything to respond.  I don't get an oops, I get no response from sysrq,
my only options is to power down.

I originally thought this problem may be caused by the use of the
ide-scsi module so I disabled that, however the problem remains.  An
interesting note, if I build support for the cdrom as a module, and
unload the module before suspending, I can then reload the module after
a resume and everything seems fine.

I've tried many various kernels from the Redhat supplied 2.4.7 and 2.4.9
series through many iterations of 2.4.16-18 pre, ac, aa, etc and I can
reproduce this problem 100% of the time on all of them.  I've never seen
this on my other laptops so I'm somewhat suspicious of a BIOS bug,
however, I'm not sure why unloading and reloading the driver would make
a difference here.

I'm looking for any sugestions or similar experiences.  Thanks in
advanced for any help on this issue.

Later,
Tom



