Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRIIAqh>; Sat, 8 Sep 2001 20:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271833AbRIIAq1>; Sat, 8 Sep 2001 20:46:27 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:19141 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S271832AbRIIAqS>; Sat, 8 Sep 2001 20:46:18 -0400
Message-ID: <3B9ABBF0.C6B9C3B7@rochester.rr.com>
Date: Sat, 08 Sep 2001 20:46:40 -0400
From: Mark Bratcher <mbratche@rochester.rr.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Plaguing ATAPI Tape drive errors in kernel 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been using a Seagate ST20000A (10GB/20GB) ATAPI tape drive since kernel
2.2.x.

This tape drive worked flawlessly as an IDE tape drive in kernel 2.2.x (up to
2.2.18).

When I upgraded to kernel 2.4.4, it failed as an IDE tape drive. It was
recommended to me that I use SCSI emulation to "fix" the problem. I did this and
although I got profuse SCSI errors on the console during tape operations, the
operations seemed to work anyway (perhaps the errors were non-fatal). I had
posted these errors with no replies or suggestions.

Now as I try kernel 2.4.9, nothing works. SCSI emulation no longer works. I get
a failure as soon as it attempts to write the tape. I have had to go back to
2.4.4 as a result. I did not attempt to go back and try IDE again on 2.4.9.

I scanned the mailing list archive and found one other person who seems to have
the same problem, but no solutions have been posted. Any ideas?

Thanks.
-- 
Mark Bratcher
---------------------------------------------------------
Escape from Microsoft's proprietary tentacles: use Linux!
