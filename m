Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276627AbRJPSoN>; Tue, 16 Oct 2001 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbRJPSoD>; Tue, 16 Oct 2001 14:44:03 -0400
Received: from w035.z208037068.nyc-ny.dsl.cnc.net ([208.37.68.35]:40599 "EHLO
	datatekcorp.com") by vger.kernel.org with ESMTP id <S276627AbRJPSnr>;
	Tue, 16 Oct 2001 14:43:47 -0400
Message-ID: <3BCC821E.9EA2C71C@datatekcorp.com>
Date: Tue, 16 Oct 2001 14:53:18 -0400
From: Puneet Jain <pjain@datatekcorp.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: how to invoke canonical processing in kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to figure out the correct approach a porting issue I am
dealing
with and would appreciate any pointers.

I am working on porting one of our communication products which works on
a
variety of OSs including Solaris, AIX etc to Linux. Basically the
product
provides a raw and canonical terminal interface to the applications and
has been implemented in STREAMS framework.

I have downloaded the LiS - Linux STREAMS (implemented by Dave Grothe)
from gcom.com. The only problem is that it is does not have any support
for terminal I/O
subsystem. So the processing that was handled by the 'ldterm' module on
other OSs now has to be handled by the available line disciplines in the
Linux kernel. While browsing the source I noticed that the default line
discipline N_TTY is probably sufficient to do the job but I am not sure
of the hooks. I am wondering if I can invoke the default line discipline
somehow or would I have to implement the canonical processing all over
again.

Any suggestions would be greatly appreciated.

Thanks,
Puneet



