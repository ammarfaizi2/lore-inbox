Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVHKUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVHKUzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVHKUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:55:23 -0400
Received: from dolly.gnuher.de ([212.227.64.154]:238 "EHLO dolly.gnuher.de")
	by vger.kernel.org with ESMTP id S932452AbVHKUzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:55:21 -0400
Date: Thu, 11 Aug 2005 22:55:10 +0200
From: Sven Geggus <sven@geggus.net>
To: linux-kernel@vger.kernel.org, mdharm-kernel@one-eyed-alien.net
Cc: davidw@dedasys.com
Subject: error: structure has no member named `scsi_scan_done'
Message-ID: <20050811205510.GA17097@diesel.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MimeOLE: Produced By Exchange Microsoft V6.6.6
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I found an older patch in the Linux Kernel Archive which enables mounting an
USB-Device as root filesystem.

This patch fixes something which I think of as a longstanding bug in the
vanilla Linux Kernel source!

Unfortunately this bug has not been fixed in the current Kernel release and
the blkdev_wakeup.patch which can be found on
http://www.dedasys.com/freesoftware/patches/blkdev_wakeup.patch does not
work anymore.

What am I supposed to change in the code to make this work again?

Looking at usb.h scsi_scan_done has been removed from us_data :(

Sven

-- 
"And I'm right.  I'm always right, but in this case I'm just a bit more
right than I usually am." (Linus Torvalds, Sunday Aug 27, 2000)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
