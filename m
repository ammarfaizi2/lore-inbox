Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUGODzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUGODzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUGODzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:55:16 -0400
Received: from web8201.mail.in.yahoo.com ([203.199.70.114]:64683 "HELO
	web8201.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S265903AbUGODzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:55:02 -0400
Message-ID: <20040715035459.91164.qmail@web8201.mail.in.yahoo.com>
Date: Thu, 15 Jul 2004 04:54:59 +0100 (BST)
From: =?iso-8859-1?q?Naveed=20Latif?= <naveedlatif786@yahoo.co.in>
Subject: 7 GB RAM Drive
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello dears,

I want to make a 7 GB RAM Disk.
thorugh PAE I can access 64 GB, but problem is that
one kernel module can't access more then 4gb at ones.
2 disks are working properly.
So I tried this method..

[DISK1....3GB]       [Disk2......4GB]
           *             *
             *          *
               *       *
           [Virtual disk  7GB]


when I recieve buffer head in virtual disk, by
changing its [bh->b_rdev = disk1] or [bh->b_rdev =
disk2]
I called generic_make_requestm but the same result,
after 4gb it is failed.


even through list mechanism by which disk have a
thread which getting bh(buffer head) from the list,
and performed the operation. these bh's coming from
virtual Disk.
This method is also failed..

Can any one help me regarding this issue, How I can I
solve this problem.


Thanks.
Naveed Latif

________________________________________________________________________
Yahoo! India Careers: Over 65,000 jobs online
Go to: http://yahoo.naukri.com/
