Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWELKGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWELKGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWELKGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:06:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34991 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751111AbWELKGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:06:24 -0400
Date: Fri, 12 May 2006 12:05:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH/rfc] schedule /sys/device/.../power for removal
Message-ID: <20060512100544.GA29010@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is very ugly, and we really should use names instead.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 421bcff..dfcfc47 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,16 @@ be removed from this file.
 
 ---------------------------
 
+What:	/sys/device/.../power
+When:	July 2007
+Files:	
+Why:	Because it takes integers, and different userland applications
+	expect different numbers to mean different things.
+	(Pcmcia expect 2 for off, some other code expects 3 for off).
+Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
 What:	devfs
 When:	July 2005
 Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
