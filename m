Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272325AbRHXVF1>; Fri, 24 Aug 2001 17:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272327AbRHXVFR>; Fri, 24 Aug 2001 17:05:17 -0400
Received: from [194.213.32.142] ([194.213.32.142]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272325AbRHXVFH>;
	Fri, 24 Aug 2001 17:05:07 -0400
Message-ID: <20010824230450.A5808@bug.ucw.cz>
Date: Fri, 24 Aug 2001 23:04:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: reiserfs failure
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Today I tried to boot my reiserfs machine, and it said:

journal-1204: .... Trying to replay onto a log block

and it will not boot. Okay, so there's a bug in reiserfs. (Kernel
2.4.7 btw, but older kernels used to be used on same machine).

But my reiserfsck is on my reiserfs partition. That used to be okay
with ext2 :-(. Can I force reiserfs to mount without journal replay?

								Pavel
PS: Please Cc: me.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
