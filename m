Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULMWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULMWAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:00:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48792 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261193AbULMWAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:00:04 -0500
Date: Mon, 13 Dec 2004 23:00:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: cdrecording status
Message-ID: <Pine.LNX.4.61.0412132255060.7005@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


an info for the enthusiastic:

I have played a little with my new cd/dvd/whatnot writer and just had this 
idea (see pic). Well then, DVD+RW makes it possible.
    http://linux01.org:2222/gfx0/madness.jpg
The worst thing is not the atime update (as cdrecord-prodvd manual says), but 
the initial mount / log replay which seeks a lot more.

Commands used were:
  cdrecord-prodvd -dev=/dev/hdc -format -v
  mkreiserfs -f /dev/hdc
(Looks like the =/dev/hdc method works best (besides =ATAPI:x,y,z or 
=ATA:x,y,z), even though cdrecord bleaks about it.)

And the question aside: is writing CD-RW in packet mode also supported in 2.6, 
like DVD+RW is?



Jan Engelhardt
-- 
ENOSPC
