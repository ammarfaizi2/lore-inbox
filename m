Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFFPcF>; Wed, 6 Jun 2001 11:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263444AbRFFPbz>; Wed, 6 Jun 2001 11:31:55 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:2688 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S263434AbRFFPbi>; Wed, 6 Jun 2001 11:31:38 -0400
Message-ID: <3B1E4CD0.FAB71F91@dm.ultramaster.com>
Date: Wed, 06 Jun 2001 11:31:28 -0400
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.6-pre1 hard lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning I was running 2.4.6-pre1 and it locked up hard in
X-windows.  The mouse cursor was frozen, and I couldn't ping the box
from another one on the network.  The sysrq did work - to an extent.  A
tried the 's u b' combination, and although the sync and remount didn't
work (filesystems needed fsck at boot - I think this means the sync and
remount never finished), the re-boot did.

System activity at the time was running a CPU intensive audio
application, which implies taking a lot of audio interrupts.  System had
been up for less than 24 hours.

I wish I had more info.

My system is a 700mhz Athlon, 256mb ram, Adaptec 2940UW, eepro100, and
sound card is emu10k1 (sb live). 

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
