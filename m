Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVEWXuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVEWXuC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEWXqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:46:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:204 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261259AbVEWXnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:43:37 -0400
Subject: ide-cd vs. DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 09:42:51 +1000
Message-Id: <1116891772.30513.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens !

Yet another case of ide-cd bogosly switching DMA of on ATAPI errors...
can this be fixed one day ? :)

The error this time is

hdb: command error: status=0x51 { DriveReady SeekComplete Error }
hdb: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdb, sector 42872

Ben.

