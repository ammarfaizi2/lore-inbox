Return-Path: <linux-kernel-owner+w=401wt.eu-S1750749AbXAEUme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXAEUme (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbXAEUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:42:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:55857 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbXAEUmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:42:25 -0500
Date: Fri, 5 Jan 2007 12:41:58 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core fix for 2.6.20-rc3
Message-ID: <20070105204158.GC7222@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a single driver core patch for 2.6.20-rc3.  It somehow got
dropped in the last round of patches for 2.6.20-rc1, and has been in the
-mm tree for quite a while.  It fixes an issue with driver names in
modules to make sure we do not create duplicate symlinks.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 kernel/module.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

---------------

Kay Sievers (1):
      Driver core: Fix prefix driver links in /sys/module by bus-name

