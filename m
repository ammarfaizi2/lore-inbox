Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbVCDXwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbVCDXwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbVCDXqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:46:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:37580 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263097AbVCDWV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:21:59 -0500
Date: Fri, 4 Mar 2005 14:21:46 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050304222146.GA1686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anything else anyone can think of?  Any objections to any of these?
I based them off of Linus's original list.

thanks,

greg k-h

------

Rules on what kind of patches are accepted, and what ones are not, into
the "linux-release" tree.

 - It can not bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
 - No "theoretical race condition" issues, unless an explanation of how
   the race can be exploited.
 - It can not contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc.)
