Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTFPQZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTFPQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 12:25:42 -0400
Received: from pcp03434297pcs.olathe01.ks.comcast.net ([68.86.97.73]:34696
	"EHLO mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S263997AbTFPQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 12:25:42 -0400
Message-ID: <39163.65.23.2.202.1055781578.squirrel@localhost>
Date: Mon, 16 Jun 2003 11:39:38 -0500 (CDT)
Subject: CONFIG_IDEDISK_MULTI_MODE in 2.4.21
From: "Nick Bartos" <spam@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ide compact flash device on a couple of machines that reports
dma errors.  In 2.4.20 I was able to set CONFIG_IDEDISK_MULTI_MODE and the
errors went away and all was peachy.

Now the errors are back in 2.4.21, and I noticed that the code that
actually implemented CONFIG_IDEDISK_MULTI_MODE was gone, such that
enabling the option did nothing.

I copied back in the old code from 2.4.20 for the option but I still get
errors, I am guessing that it was removed because something was changed so
that it no longer mattered or something.

So is CONFIG_IDEDISK_MULTI_MODE somehow obsolete or was this an over site?

If CONFIG_IDEDISK_MULTI_MODE is not supposed to matter anymore what should
we do about trying to fix the errors that CONFIG_IDEDISK_MULTI_MODE used
to (set_multimode: status=0x51 { DriveReady SeekComplete Error } & 
set_multimode: error=0x04 { DriveStatusError })?


