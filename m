Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTFFJqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTFFJqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:46:14 -0400
Received: from verein.lst.de ([212.34.189.10]:52178 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261710AbTFFJqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:46:13 -0400
Date: Fri, 6 Jun 2003 11:59:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kurt.Robideau@comtrol.com
Cc: linux-kernel@vger.kernel.org
Subject: rocket driver update backs out fixes
Message-ID: <20030606095942.GA20568@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, Kurt.Robideau@comtrol.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -2.5 () USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't you send driver updates to lkml first?  The rocket.c
update backs out at least the check_region fixes an possibly
more.  Instead of sending small incremental patches you slap
in a monster patch that ignores what was there before and does
silly things like massive cpp abuse.  Also when you change
the pci probing please make it use a new-style pci driver, etc..

The driver already was a mess and you made it even worse.
