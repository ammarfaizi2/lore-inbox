Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWGLX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWGLX0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWGLX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:26:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:17292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751476AbWGLX0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:26:36 -0400
Date: Wed, 12 Jul 2006 16:22:49 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [GIT PATCH] W1 patches for 2.6.18-rc1
Message-ID: <20060712232249.GA22654@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some tiny w1 patches that have been in the -mm tree for a
while.  They fix a bug, remove an unneeded .h file, and update the
	MAINTAINERS file.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 MAINTAINERS                 |    1 -
 drivers/w1/masters/ds2482.c |    2 +-
 drivers/w1/w1_io.h          |   36 ------------------------------------
 3 files changed, 1 insertions(+), 38 deletions(-)
 delete mode 100644 drivers/w1/w1_io.h

---------------

Adrian Bunk:
      w1: remove drivers/w1/w1.h

Ben Gardner:
      w1: fix idle check loop in ds2482

Evgeniy Polyakov:
      W1: remove w1 mail list from lm_sensors.

