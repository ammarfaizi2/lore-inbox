Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTKJW4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTKJW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:56:07 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:44759
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264162AbTKJW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:56:04 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mochel@osdl.org
Subject: More on patrick's -test9 suspend code.
Date: Mon, 10 Nov 2003 16:52:36 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311101652.36590.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what failing to suspend and booting back up to the desktop looks like:

Stopping tasks: 
==============================================================================================================================|
Freeing memory: .|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
ohci_hcd 0000:00:14.0: USB continue from host wakeup
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
eth0: New link status: Connected (0001)
blk: queue cb558c00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done

Rob
