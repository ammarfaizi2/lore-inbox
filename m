Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271616AbRIJTSN>; Mon, 10 Sep 2001 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271617AbRIJTSD>; Mon, 10 Sep 2001 15:18:03 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:51982 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S271616AbRIJTRo>; Mon, 10 Sep 2001 15:17:44 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256AC3.0069F85E.00@smtpnotes.altec.com>
Date: Mon, 10 Sep 2001 14:15:14 -0500
Subject: ntfs problem with 2.4.10-pre7
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since upgrading to 2.4.10-pre7, accessing my Win2000 ntfs partition (mounted
read-only) causes a lockup.  There are no oops messages on the console or in the
logs; if I'm in text mode when it happens the system still responds to <alt-f1>
etc. and to <alt-sysrq> but not to anything else.  If I'm in X nether the mouse
nor the keyboard respond.  This is on a ThinkPad 600X with a kernel compiled
with egcs-2.91.66.  The last kernel that worked correctly for me was
2.4.10-pre4.  I skipped -pre5; -pre6 (with Anton's one-line patch applied to
allow compiling with egcs-2.91.66) gives the same lockup as -pre7.

Wayne


