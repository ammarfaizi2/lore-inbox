Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAAGAj>; Mon, 1 Jan 2001 01:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAAGA3>; Mon, 1 Jan 2001 01:00:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23047 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129771AbRAAGAR>;
	Mon, 1 Jan 2001 01:00:17 -0500
Date: Mon, 1 Jan 2001 00:29:55 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: feature flags set on rev 0 fs
Message-ID: <Pine.LNX.4.31.0101010027100.103-100000@clubneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a new warning with the 2.4.0-prerelease (could have been
introduced in -pre11 or 12):

EXT2-fs warning: feature flags set on rev 0 fs, running e2fsck is recommended

Well I've run e2fsck (version 1.18) twice, and looked at the options for
tune2fs.

Is there an easy way to change the rev of the fs, without a format and
restore?

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
