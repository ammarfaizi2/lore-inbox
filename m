Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTATApV>; Sun, 19 Jan 2003 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbTATApV>; Sun, 19 Jan 2003 19:45:21 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:41468 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267736AbTATApU>;
	Sun, 19 Jan 2003 19:45:20 -0500
Date: Mon, 20 Jan 2003 00:53:19 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: out of place comment fs/binfmt_elf.c:365
Message-ID: <Pine.LNX.4.44.0301200052070.8560-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in fs/binfmt_elf.c around line 365 in 2.5 and same sorta place in 2.4 is a
comment like so...

/* Now use mmap to map the library into memory. */

but the code proceeds to do no such thing.. it has done it already....

the next lines are another comment stating now fill out the bss..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


