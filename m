Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269734AbUHZWQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269734AbUHZWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUHZWOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:14:23 -0400
Received: from waste.org ([209.173.204.2]:19906 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269745AbUHZWKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:10:44 -0400
Date: Thu, 26 Aug 2004 17:10:39 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ketchup 0.9 automatic kernel patching utility
Message-ID: <20040826221039.GD31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released version 0.9 of ketchup. Ketchup manages the task of
downloading and patching between various kernel trees, taking most of
the busy work out of keeping your kernel trees current. This version
should fix the issues with the new 4-part versioning scheme.

Features:

- knows about multiple trees, including 2.4, 2.6, 2.6-bk, 2.6-mm, and 2.6-tiny
- can automatically determine the latest version of a given tree
- can patch between any release in the same major branch (eg 2.4 or 2.6)
- automatically downloads patches as needed
- maintains a cache of patches which can be shared among users
- verifies GPG signatures
- can print current versions and URLs for use in automation scripts

Sample usage:

$ ketchup 2.6
2.6.8-rc3-mm1 -> 2.6.8.1
Applying 2.6.8-rc3-mm1.bz2 -R
Applying patch-2.6.8-rc3.bz2 -R
Applying patch-2.6.8.bz2
Applying patch-2.6.8.1.bz2
$

Available at:

http://selenic.com/ketchup/ketchup-0.9

-- 
Mathematics is the supreme nostalgia of our time.
