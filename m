Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUGDLcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUGDLcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUGDLcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:32:03 -0400
Received: from smtp07.web.de ([217.72.192.225]:20636 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S265517AbUGDLcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:32:00 -0400
Subject: [BUG] FAT broken in 2.6.7-bk15
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org
Content-Type: text/plain
Date: Sun, 04 Jul 2004 13:28:28 +0200
Message-Id: <1088940508.655.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The recent changes in 2.6.7-bk15 broke FAT support. I am doing some
rescue backup systems here using tools like syslinux and mtools to
format a normal msdos disk (for el-torito). I figured out that after
creating and formating of these disks that it is impossible to mount
them with 'msdos' or 'vfat'. Even recompiling mtools with current
changes show the same issues. Please someone check up and fix the issues
(maybe reverting the changes).

PS: I am not subscribed to this list so in case you need to CC: me.


