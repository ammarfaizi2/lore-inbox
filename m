Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHYQeK>; Sat, 25 Aug 2001 12:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHYQeA>; Sat, 25 Aug 2001 12:34:00 -0400
Received: from [209.250.60.228] ([209.250.60.228]:12804 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S269756AbRHYQdz>; Sat, 25 Aug 2001 12:33:55 -0400
Date: Sat, 25 Aug 2001 11:33:44 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Odd __alloc_pages failure in 2.4.9
Message-ID: <20010825113344.A528@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:24am  up 6 min,  0 users,  load average: 2.43, 1.08, 0.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel 2.4.9, if I start xcdroast 0.98alpha9 as an ordinary
user, the system seems to freeze indefinitely.

If I start it as root, however, the system only freeze for 2-3 seconds.
After this time, if I check dmesg, I get a slew of __alloc_pages
failures, even 0-order failures.

Being unable to diagnose the complete lockup in the user case any
better, I assume that this is what's happening there, too, only
indefinitely.

The system is an AMD Thunderbird 900MHz with 2 IDE CD-ROM drives, both
use ide-scsi.  One is a burner, the other is a DVD-ROM drive.

I'll try and get a backtrace of whats happening during the lockup later
when I can hook up my serial console.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
