Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTKQArH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 19:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTKQArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 19:47:07 -0500
Received: from pcp02850536pcs.parkvl01.md.comcast.net ([68.85.218.116]:17929
	"EHLO www.watkins-home.com") by vger.kernel.org with ESMTP
	id S263262AbTKQArD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 19:47:03 -0500
Message-Id: <200311170047.hAH0l2E15254@www.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Automatic Write Reallocation Enable, question?
Date: Sun, 16 Nov 2003 19:46:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20031114182927.GA8810@gtf.org>
Thread-Index: AcOq3cGniUKd4RiHQMeswVTr26PpGgBxQqmw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hard disks support some programmable options.

Automatic Write Reallocation Enable (AWRE):
  On, drive automatically relocates bad blocks detected during write
operations.  Off, drive creates Check Condition status with sense key of
Medium Error if bad blocks are detected during write operations.

Automatic Read Reallocation Enable (ARRE):
  On, drive automatically relocates bad blocks detected during read
operations.  Off, drive creates Check Condition status with sense key of
Medium Error if bad blocks are detected during read operations.

These options are both off.

Would md be happier if these were on?  This would hide recoverable errors
from md.

Any opinions?

My disks are ST118202LC.

Thanks.


