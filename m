Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUIUJQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUIUJQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIUJQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:16:45 -0400
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:30338 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267542AbUIUJPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:15:49 -0400
Date: Tue, 21 Sep 2004 11:15:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: 2.4.22: wrong return value of do_odirect_fallback
Message-ID: <20040921091535.GA29746@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.4.22, 

static int do_odirect_fallback(struct file *file, struct inode *inode,
                               const char *buf, size_t count, loff_t *ppos)

it should probably return ssize_t. Can someone check it is fixed
in latest 2.4?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
