Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUKSVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUKSVuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKSVuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:50:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:48529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261602AbUKSVsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:48:20 -0500
Date: Fri, 19 Nov 2004 13:47:10 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core fixes for 2.6.10-rc2
Message-ID: <20041119214710.GA15517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two bugfixes for the driver core / sysfs against 2.6.10-rc2.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 fs/sysfs/dir.c |    3 ++-
 lib/kobject.c  |    6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)
-----


Gerd Knorr:
  o fix kobject varargs bug

Maneesh Soni:
  o fix oops in sysfs_remove_dir()

