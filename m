Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVIKQCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVIKQCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVIKQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:02:47 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:468 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964825AbVIKQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:02:46 -0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: What's up with the GIT archive on www.kernel.org?
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:02:44 +0200
Message-ID: <m3mzmjvbh7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since about 20 hours ago, it seems the
linux/kernel/git/torvalds/linux-2.6.git/ archive on www.kernel.org
alternates between at least two different HEAD commits. First it was

        40 hours ago [PATCH] md: fix BUG when raid10 rebuilds without
        enough drives

then it changed to 

        15 hours ago Merge
        master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6

then it changed back to the raid10 commit. It looks like it has
flipped back and forth quite a few times. Currently it seems to happen
once every couple of minutes or so.

This affects both gitweb and rsync, but the rsync flipping is not
synchronized with the gitweb flipping.

Does anyone else see this? "host www.kernel.org" gives me two IP
addresses:

        www.kernel.org is an alias for zeus-pub.kernel.org.
        zeus-pub.kernel.org has address 204.152.191.5
        zeus-pub.kernel.org has address 204.152.191.37

Is it possible that one of those computers hasn't received the latest
changes for some reason?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
