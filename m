Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVCOKif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVCOKif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVCOKie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:38:34 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:39604 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262373AbVCOKia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:38:30 -0500
Date: Tue, 15 Mar 2005 10:38:30 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Clayton <andrew@digital-domain.net>, Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sf.net
Subject: drm lockups since 2.6.11-bk2
Message-ID: <Pine.LNX.4.58.0503151033110.22756@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	Andrew Clayton reported lockups on the dri list issues since -bk2
and bug 4337 on bugzilla.kernel.org looks like it might be the same
thing..

This leads me to think the AGP multi-bridge patches are at fault... (for
once my laziness in merging late instead of early gave a good gap in the
patches...)

I'm "offline" in sense of I can write this mail and respond but have not
access to a Linux system, my bitkeeper trees, ssh keys for anywhere of
interest.. and am in the wrong country, it'll be the 23rd/24th before I am
back at my desks...

I might get time to do a code review, my main worry is that all the
problems reported with those patches in -mm made it into the patchset that
went into Linus.. mainly things like forgetting to memset certain
structures to 0 and sillies like that...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

