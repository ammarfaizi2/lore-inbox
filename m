Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264693AbSJOT5M>; Tue, 15 Oct 2002 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSJOT5M>; Tue, 15 Oct 2002 15:57:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29457 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264693AbSJOT5L>; Tue, 15 Oct 2002 15:57:11 -0400
Date: Tue, 15 Oct 2002 22:05:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Eaten filesystem and unhelpfull fsck
Message-ID: <20021015200511.GD19330@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I managed to kill filesystem on my omnibook... Now I'm pretty sure
most of data should be undamaged [I did not do any long writes to it],
but mount refuses to mount it and e2fsck refuses that, too.

fsck /dev/hda4
fsck 1.24a (02-Sep-2001)
...
try running...:

	e2fsck -b 8193.

e2fsck -b 8193 /dev/hda4
....suggests me to run e2fsck -b 8193. Too bad. debugfs refuses to
mount it, too. How do I get my data back?
								Pavel
-- 
When do you have heart between your knees?
