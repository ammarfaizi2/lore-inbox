Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271596AbRHPReY>; Thu, 16 Aug 2001 13:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRHPReP>; Thu, 16 Aug 2001 13:34:15 -0400
Received: from [195.66.192.167] ([195.66.192.167]:7431 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271596AbRHPReM>; Thu, 16 Aug 2001 13:34:12 -0400
Date: Thu, 16 Aug 2001 20:36:33 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <171437787.20010816203633@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: OT: BIG trouble with hw RAID
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is entirely offtopic. Sorry.

On my job we have a big box. Some time ago it was a dream machine:

HP NetServer LX Pro - dual PPro200, 512 MB RAM
with two internal RAID bays up to 8 disks each +
HP NetServer Storage System/6 - external RAID box for up to 8
disks.

It was running NT 4.0 SP3 and Oracle database (at least 10GB).

Today it went down due to extended power failure. UPS drained.
After we turned it back on and logged in, we discovered that network
connection wasn't working.

I tried to fix it, and only made things worse: box showed blue screen
of death whenever user tries to log on in VGA mode (interestingly it
went to "Press Ctrl-ALt-Del" and died only immediately after logon)

I thought I need to access these disks bypassing failing NT and
unplugged external RAID box, plugging my SCSI disk with Linux
instead. But... it seems it does not see my disk even when I boot
from diskettes in DOS and then thru LOADLIN to linux.

After I put everything back as it was - !!!! - it does not boot NT at
all. Looks like BIOS reconfigured RAID arrays erroneously.

PLEASE!
If anybody have experience with these HP NetServers - answer me!
How I can reconfigure these RAID arrays thru BIOS?
I will not just sit and wait and will try figure it out.
However, any help will be appreciated.
Please tell me what info do you need about this machine and its
current status to help me fix this breakage.
-- 
Best regards,
VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


