Return-Path: <linux-kernel-owner+w=401wt.eu-S1030346AbWLTUCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWLTUCc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWLTUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:02:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030346AbWLTUCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:02:19 -0500
Date: Wed, 20 Dec 2006 12:01:51 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core patches for 2.6.20-rc1
Message-ID: <20061220200151.GC1698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor driver core patches for 2.6.20-rc1

The descriptions of them are below.

All of these patches have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h

 drivers/acpi/ibm_acpi.c |    4 ++--
 include/linux/device.h  |    2 ++
 include/linux/kobject.h |   11 ++++++-----
 init/main.c             |    2 +-
 lib/kobject_uevent.c    |   44 ++++++++++++++++++++++++++++++--------------
 lib/kref.c              |    7 +------
 6 files changed, 42 insertions(+), 28 deletions(-)

---------------

Adrian Bunk (1):
      Driver core: proper prototype for drivers/base/init.c:driver_init()

Aneesh Kumar K.V (1):
      kobject: kobject_uevent() returns manageable value

Venkatesh Pallipadi (1):
      kref refcnt and false positives

