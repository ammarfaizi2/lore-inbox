Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130933AbRCFFIw>; Tue, 6 Mar 2001 00:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130937AbRCFFIc>; Tue, 6 Mar 2001 00:08:32 -0500
Received: from smtp6vepub.gte.net ([206.46.170.27]:28484 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S130933AbRCFFI3>; Tue, 6 Mar 2001 00:08:29 -0500
Message-ID: <3AA470C6.1A2BD379@neuronet.pitt.edu>
Date: Tue, 06 Mar 2001 00:08:22 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LK <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.3 and new aic7xxx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just to report on a the behavior of this driver. I've a dual
channel Adaptec 7895 controller. The adapter BIOS is configured to boot
from devices in channel B. I boot from  a disk connected to channel B
and when the kernel loads the driver the disks from channel A are seen
first, resulting in the drive names changing from, say sda to sdb. This
does not happen with 2.2.18 or 2.4.2. Is there an option to reverse the
order? I saw some of the options in the code, but none about this.

In any case, booting halts since the root file system can't be mounted.
It didn't fry my disks, either :)

-- 
     Rafael
