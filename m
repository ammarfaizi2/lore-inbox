Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWELTFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWELTFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWELTFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:05:32 -0400
Received: from ns.suse.de ([195.135.220.2]:1185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751354AbWELTFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:05:30 -0400
Date: Fri, 12 May 2006 12:03:32 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C bugfixes for 2.6.17-rc4 - resend
Message-ID: <20060512190332.GA22627@kroah.com>
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

The full patch series was sent to the sensors mailing list the last time
this notice was sent out, so I'll not resend them.

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

