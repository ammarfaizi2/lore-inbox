Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUJATZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUJATZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUJATZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:25:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:38057 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266218AbUJATZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:25:32 -0400
Subject: Loops in the Signed-off-by process
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Message-Id: <1096658717.3684.980.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 12:25:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent ppc64 updates, a few patches in my tree didn't merge
very easily.  Being lazy, I asked one of the ppc64 developers to resync
them for me.  But, it happened to be someone other than the original
author that did this.

When they got sent to me again, the original author's (and my)
Signed-off-by: lines were gone, replaced by the nice fellow who merged
them.  This was certainly an artifact of how he generates patches and
obviously not malicious, but I still wonder what the "right" thing to do
is.

Do we show the logical flow?

Signed-off-by: original author
Signed-off-by: patch merger
Signed-off-by: tree maintainer

Or the actual flow of the patches, showing that they came back to the
tree maintainer twice?

Signed-off-by: original author
Signed-off-by: tree maintainer
Signed-off-by: patch merger
Signed-off-by: tree maintainer

Or, does it even really matter?

-- Dave

