Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWJQSjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWJQSjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJQSjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:39:11 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:21702 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751406AbWJQSjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:39:09 -0400
Date: Tue, 17 Oct 2006 20:38:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: axboe@suse.de
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fs/Kconfig question regarding CONFIG_BLOCK
Message-ID: <Pine.LNX.4.61.0610172037370.30104@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



fs/Kconfig has:

if BLOCK
menu "DOS/FAT/NT Filesystems"
...
<stuff here>
...
endmenu
endif


Why is it wrapped into BLOCK, or, why are all of the other filesystems 
which require a block device?


	-`J'
-- 
