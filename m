Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWDDJ0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWDDJ0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWDDJ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:26:42 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:23170 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932411AbWDDJ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:26:41 -0400
Date: Tue, 4 Apr 2006 11:26:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Simon Evans <spse@secret.org.uk>
Subject: [Patch 0/3] Remove blkmtd
Message-ID: <20060404092628.GA12277@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removed blkmtd in three steps:
1. Mark it as deprecated,
2. mark block2mtd, the replacement, as no longer experimental and
3. remove the driver.

Eric suggested sending patch 1 and 2 directly to Linus while leaving
patch 3 in -mm as long as klibc remains there as well.  Andrew, do you
prefer me to send the first two patches to Linus or will you rather do
it yourself?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
