Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUCOGRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 01:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCOGRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 01:17:00 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:55993 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262281AbUCOGQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 01:16:59 -0500
Date: Sun, 14 Mar 2004 22:16:56 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200403150616.i2F6Gu2Z030020@work.bitmover.com>
To: bitkeeper-users@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: BK/Web improvements (includes patch server)
Cc: dev@work.bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a few changes to the BK/Web service on BK/Bits.  There are some
cosmetic changes but the substantial changes are as follows:

    - Traditional diff -Nur style patches served as text/plain.  You can 
      now wget your favorite patch.  I fully expect that the BK users in
      the kernel will start including URLs to the patches as part of the
      submission process.  For the BK users, the URL you want is

      bk changes -r+ -nd'http://$proj.bkbits.net/$repo/gnupatch@:MD5KEY:'

      where you fill in $proj and $repo and this assumes that you want to
      include a pointer to the most recent changeset.

    - Bookmarkable changeset and patch links.  When you navigate to a 
      changeset you'll see a link that says "Bookmarkable link".  If you
      click on that you'll see the URL change from cset@1.1234 to 
      cset@<MD5KEY>.  If you use the latter in your mail messages to your
      friends that URL will always work; the first one won't.  

    - Added sorting to the stats page, now you can see who is busy faster.
      The definition of "recent" on the stats page is the last 3 months.

    - fixed searching (it works, it's still slow on large trees)

    - cleaned up some bugs in the advertising (we're looking for people so
      I stuck ads up on the web pages).

Check it out at http://www.bkbits.net and let me know if you find a bug.
