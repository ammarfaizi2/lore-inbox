Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWBLRjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWBLRjB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWBLRjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:39:01 -0500
Received: from verein.lst.de ([213.95.11.210]:51352 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750820AbWBLRjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:39:00 -0500
Date: Sun, 12 Feb 2006 18:38:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] new dasd ioctl patchkit
Message-ID: <20060212173843.GA26035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new patchkit to fix the dasd ioctl mess, against
2.6.16-rc2-mm1.  I've built an s390 crosscompiler to compile-test them and
I've booted the resulting kernel with a debian image in hercules (not that
this excercises the ioctl path a whole lot, but I didn't find tools that
actually used any of these ioctls).

The patches are also split more fine-grained than last time.
