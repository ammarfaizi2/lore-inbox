Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVDSEkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDSEkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVDSEkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 00:40:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:8920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261319AbVDSEkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 00:40:02 -0400
Date: Mon, 18 Apr 2005 21:39:38 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419043938.GA23724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, let's try some small i2c and w1 patches...

Could you merge with:
	kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

It contains 4 small patches, 2 i2c and 2 w1 bugfixes, diffstat is
below, I'll figure out how to send the individual patches later.

thanks,

greg k-h

 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/via686a.c |    7 ++-----
 drivers/w1/w1.c             |    9 +++++----
 drivers/w1/w1_smem.c        |    4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)
     
