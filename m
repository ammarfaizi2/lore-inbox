Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUL0T7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUL0T7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUL0T5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:57:17 -0500
Received: from dialin-162-123.tor.primus.ca ([216.254.162.123]:7808 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261960AbUL0T4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:56:52 -0500
Date: Mon, 27 Dec 2004 14:56:45 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: waiting 10s before mounting root filesystem?
Message-ID: <20041227195645.GA2282@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I make the kernel to wait about 10s before attempting to mount
root filesystem?  Is there obscure kernel parameter?

I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
root filesystem.  All relevant USB and SCSI modules are compiled into
the kernel.  I think kernel is too fast in panicking.  I would like the
kernel to wait about 10s until 'usb-storage' and 'sd_mod' work out all
the details.

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
