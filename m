Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVBML3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVBML3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 06:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVBML3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 06:29:41 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:62080 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261261AbVBML3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 06:29:40 -0500
Date: Sun, 13 Feb 2005 11:29:38 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: mingo@elite.hu, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: SiS drm broken during 2.6.9-rc1-bk1
Message-ID: <Pine.LNX.4.58.0502131124090.16528@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just conducted a binary search to see when the SIS drm stopped
working... and it was 2.6.9-rc1-bk1 from looking at it the new virtual
memory layout is the most likely patch to have broken things... I haven't
confirmed it is this particular patch yet, tomorrow I'll get some time to
do it ..

The SIS is a quite simple drm, so I'm not sure what has been broken, Ingo
can you think of anything that this patch might do to the drm,

the bug is that gears no longer draw anything, but no errors appear
anywhere.. the window is just empty...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

