Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbULEIcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbULEIcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 03:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbULEIcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 03:32:13 -0500
Received: from av7-2-sn2.hy.skanova.net ([81.228.8.109]:28349 "EHLO
	av7-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261282AbULEIcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 03:32:11 -0500
Date: Sun, 5 Dec 2004 09:32:09 +0100 (CET)
Message-Id: <200412050832.iB58W9104024@d1o408.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: andrea@suse.de
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-12-05 09:32:09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know... Said that I wouldn't come back unless there was a problem. But 
with these results! The patch is fantastic.

My problem app, blender, allocated all remaining physical memory and 360 
megs (of the 1 gig) swap but remained running. No oom-kill involved at 
all. This is a first with that app (in such a mode, with such a large 
working set of pictures). 500 1.2 meg uncompressed targa pictures 
animated in the graphical window of "Sequence Editor" on my system (256 
meg real mem). Wow.

The oom-kill/swap/memory handling/whatever must have been really sick.

Thank You!
Mats Johannesson (time to pay back by trying 2.6.10-rc3)

