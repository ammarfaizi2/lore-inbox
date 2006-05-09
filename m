Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWEIUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWEIUI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEIUI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:08:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36792 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWEIUI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:08:56 -0400
Date: Tue, 9 May 2006 13:07:18 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C bugfixes for 2.6.17-rc3
Message-ID: <20060509200718.GA7176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c bug fixes for a single driver against your current git
tree.  They all have been in the -mm tree for a few weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h


 drivers/i2c/busses/scx200_acb.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

---------------

Jean Delvare:
      scx200_acb: Fix return on init error
      scx200_acb: Fix resource name use after free

Jordan Crouse:
      scx200_acb: Fix for the CS5535 errata

