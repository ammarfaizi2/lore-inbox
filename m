Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRIXVP0>; Mon, 24 Sep 2001 17:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272368AbRIXVPR>; Mon, 24 Sep 2001 17:15:17 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:3200 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S271906AbRIXVPF>;
	Mon, 24 Sep 2001 17:15:05 -0400
Date: Mon, 24 Sep 2001 14:15:30 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
Subject: [BUG?] ext3 0.9.10-2410 - root partition never marked dirty
Message-ID: <Pine.LNX.4.33.0109241409490.990-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the aforementioned changes in 2.4.10 has prevented the root
filesystem from having its superblock updated as dirty.  It may be my
imagination, but since the root fs is already mounted ro when it's
remounted rw, the superblock isn't being updated with the needs_recovery
flag.

-Ryan

