Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFAFEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFAFEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFAFEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:04:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:55005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261271AbVFAE7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:59:53 -0400
Date: Tue, 31 May 2005 22:09:42 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [GIT PATCH] I2C bugfix for 2.6.12-rc5
Message-ID: <20050601050942.GA26994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a single i2c patch for the 2.6.12-rc5 tree that fixes a bug.
This patch has been in the -mm tree for quite some time.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

The full patch will be sent to the linux-kernel and sensors mailing
list, if anyone wants to see them.

thanks,

greg k-h

 MAINTAINERS                      |    6 +++++
 drivers/i2c/busses/i2c-ali1563.c |   46 ++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

------------

Rudolf Marek:
  o I2C: ALI1563 SMBus driver fix


