Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTKHGdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 01:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTKHGdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 01:33:43 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:17029 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261598AbTKHGdm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 01:33:42 -0500
Date: Fri, 7 Nov 2003 22:33:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Weird ext2 problem in 2.4.18 (redhat)
Message-ID: <20031108063341.GA8349@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BitKeeper source tree looks like

	BitKeeper/  SCCS/  doc/  man/  src/

I have a repository where it looks like

	 src/  BitKeeper/  PENDING/  RELEASE-NOTES  SCCS/  doc/  man/  src/

That first src/ is actually " src/" and it has some rather strange behaviour.
It's a different directory inode than "src/" but if I create a file in " src/"
it shows up in "src/" and vice versa.

Hey, neato, it gets weirder.  I went to go run an example and now most of
the files in " src/" are gone, most but not all.

I'm merrily backing up this disk while I can but if this rings any bells
someone let me know.  Thanks.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
