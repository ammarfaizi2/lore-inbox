Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWJ3KpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWJ3KpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWJ3KpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:45:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59546 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161236AbWJ3KpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:45:23 -0500
To: linux-arch@vger.kernel.org
Subject: dealing with excessive includes
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUdv-0002nW-5g@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:45:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patches follow.  Again, it's still preliminary and needs more
testing.  The good thing is that if it's broken it simply won't build.

	All that stuff is going after low-hanging fruits and it gives
one hell of dependency counts reduction for widely used headers.

	Enjoy.
