Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131699AbRAAIKB>; Mon, 1 Jan 2001 03:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRAAIJw>; Mon, 1 Jan 2001 03:09:52 -0500
Received: from duracef.shout.net ([204.253.184.12]:22802 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S131699AbRAAIJn>; Mon, 1 Jan 2001 03:09:43 -0500
Date: Mon, 1 Jan 2001 01:38:55 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200101010738.BAA12932@duracef.shout.net>
To: jjs@pobox.com, kaos@ocs.com.au, mec@shout.net
Subject: Re: [patch] 2.4.0-prerelease drm and modversions
Cc: alan@lxorguk.ukuu.org.uk, dri-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mec> This looks good to me.  It's missing a dependency though.  If foo-mod.c
mec> exists, and someone edits or patches foo.c, then foo-mod.c needs to be
mec> re-created.

Doh.  It's a symlink, not a copy.  It never needs updating.

I'll go debug a Hangman program or something.

Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
