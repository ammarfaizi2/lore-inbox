Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbULOARJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbULOARJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbULOARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:17:09 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:49073 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261796AbULNXbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:31:18 -0500
Subject: ioctl assignment strategy?
From: Al Hooton <al@hootons.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 15:31:07 -0800
Message-Id: <1103067067.2826.92.camel@chatsworth.hootons.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It was 6-7 years ago that I last worked on driver level stuff, I expect
I've got a whack with a cluebat coming....

	Do we care about "official" ioctl assignments any more?  Or, am I not
grokking some change that removes the need to submit patched files to
keep externally developed drivers from potentially colliding with their
ioctl's?  

	If we still need to do something to make our ioctl's "official", what
is it?  The comments in Documentation/ioctl-number.txt *can't* still be
accurate, I don't believe.

	I've been through ioctl-number.txt, looked through the various
ioctl(s).h and related kernel source for managing ioctl's, believe I
understand the _IOxx and _IOxx_xxx macros, searched the list archives,
googled, and I'm left with this one answered question...


Thanks,
Al


