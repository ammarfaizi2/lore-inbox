Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266034AbRGCWIx>; Tue, 3 Jul 2001 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266036AbRGCWIn>; Tue, 3 Jul 2001 18:08:43 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:12928 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S266034AbRGCWIe>; Tue, 3 Jul 2001 18:08:34 -0400
Message-ID: <3B424300.9D804101@dm.ultramaster.com>
Date: Tue, 03 Jul 2001 18:11:12 -0400
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: SCHED_FIFO task blocks magic sysrq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like the sysrq code can get starved by a SCHED_FIFO task.  I
learned this by having an accidentally runaway SCHED_FIFO task which
locked up my system.  No SAK, no sync, no unmount, no reboot.  Big Red
Button.

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
