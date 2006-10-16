Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422919AbWJPXKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbWJPXKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWJPXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:10:19 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:56454 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422915AbWJPXKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:10:17 -0400
Date: Tue, 17 Oct 2006 01:08:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mingming Cao <cmm@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: config EXT4DEV_FS question
Message-ID: <Pine.LNX.4.61.0610170100480.30479@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



something I have seen during `make oldconfig`, in fs/Kconfig we find:

config EXT4DEV_FS
   ...

  To compile this file system support as a module, choose M here. The
  module will be called ext4dev.  Be aware, however, that the
  filesystem of your root partition (the one containing the directory
  /) cannot be compiled as a module, and so this could be dangerous.


Why can't this be compiled as a module when / is ext4? There are a lot
of people out there having no filesystem code included in the kernel at
all (includes at least SUSE users using the default vendor kernel), but
instead have them as modules in their initramfss (what's the proper
plural of initramfs?). What is it that makes ext4 different?

	-`J'
-- 
