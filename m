Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271284AbTG2HPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271286AbTG2HPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:15:05 -0400
Received: from host-246-133.tiscali.it ([195.130.246.133]:43444 "EHLO
	scilla.tiscali.it") by vger.kernel.org with ESMTP id S271284AbTG2HPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:15:02 -0400
Date: Tue, 29 Jul 2003 09:14:38 +0200
From: Francesco Messineo <iz5dwf@amsat.org>
To: linux-kernel@vger.kernel.org
Subject: [iz5dwf@amsat.org: i2o_block.c randomness patch]
Message-ID: <20030729071438.GA10872@tiscali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

best regards

Francesco Messineo

----- Forwarded message from Francesco Messineo <iz5dwf@amsat.org> -----

From: Francesco Messineo <iz5dwf@amsat.org>
To: alan@lxorguk.ukuu.org.uk
Subject: i2o_block.c randomness patch

Hello,

I have a couple of servers that use only i2o raid controllers, no keyb,
no mouse, so they don't get almost any randomness. I think there's
need for a small patch on i2o_block.c file:

add_blkdev_randomness(MAJOR(req->rq_dev));

that should be added before line 449 (for the i2o_block.c found in the 
stock 2.4.21 kernel), the patched kernel looks like working fine.

What do you think about it?

Thank you.

Francesco Messineo

----- End forwarded message -----
