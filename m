Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRAGWMQ>; Sun, 7 Jan 2001 17:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133096AbRAGWMF>; Sun, 7 Jan 2001 17:12:05 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:27802 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132701AbRAGWMB>; Sun, 7 Jan 2001 17:12:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel <linux-kernel@vger.kernel.org>, newbie@XFree86.Org
Subject: performance boost from merging linux-2.4.0, xfree86-4.02
Date: Sun, 7 Jan 2001 17:14:59 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01010717145901.00573@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for what it's worth:

this afternoon i conducted an experiment: i copied everything that 
was newer from 
[xfree-4.02-sourcedir]/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel 
to my [linux-2.4.0-sourcedir]/drivers/char/drm and then built a 
monolithic kernel containing agpgart, dri, and mga support. the 
performance improvement is simply tremendous -- gears, for instance, 
in the XscreenSavers module form, is running at at least 75 fps at 
1280x1024. really screaming.

obviously, anybody wanting to play with this needs to backup 
everything first. but i think the experiment is well worth it for 
anyone competent to build a kernel and who is interested in the 
potential of the dri stuff in X.

this also suggests that probably the kernel dri stuff could stand an 
update.
-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
