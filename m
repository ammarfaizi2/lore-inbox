Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbRBAQDF>; Thu, 1 Feb 2001 11:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130752AbRBAQCz>; Thu, 1 Feb 2001 11:02:55 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:39066 "EHLO
	hereintown.net") by vger.kernel.org with ESMTP id <S130751AbRBAQCs>;
	Thu, 1 Feb 2001 11:02:48 -0500
Date: Thu, 1 Feb 2001 11:14:55 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Quotas not updating.
Message-ID: <Pine.LNX.4.31.0102011107580.471-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.1 (had been using 2.4.0 since it was released) with quota
2.00 on an ext2 filesystem mounted as /home.

When a file is created or deleted from the file system the quota usage is
not updated.  If I run a "quotacheck -a" everything gets updated, but
quickly after as mail is delivered or what ever the numbers get out of
sync.

If I run quotacheck and a user is updated to be over quota I can no longer
create files as that user, so quotas are being inforced.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
