Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUEWE2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUEWE2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 00:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUEWE2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 00:28:34 -0400
Received: from main.gmane.org ([80.91.224.249]:23518 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262213AbUEWE2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 00:28:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: consistent ioctl for getting all net interfaces?
Date: Sat, 22 May 2004 21:28:28 -0700
Message-ID: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-221-19.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm interested in not having to parse /proc/net/dev to get a list of all
available (not necessarily even up) interfaces on the system. I
investigated the ioctl SIOCGIFCONF, but it seems to behave differently on
2.4 and 2.6 series kernels, e.g. sometimes it won't return all interfaces.

Is there some end-all ioctl that does what I want, or am I forever doomed
to process /proc/net/dev (in C, no less..)?

Please CC me on replies, I don't read this list very often any more.

Thanks,

-- 
Joshua Kwan


