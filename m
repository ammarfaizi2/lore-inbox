Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbULZTTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbULZTTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 14:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbULZTTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 14:19:23 -0500
Received: from dsl-209-183-18-152.tor.primus.ca ([209.183.18.152]:3968 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261283AbULZTTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 14:19:21 -0500
Date: Sun, 26 Dec 2004 14:19:18 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: usb-storage loads scsi_mod, but not sd_mod (2.6.9)
Message-ID: <20041226191918.GA5166@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear USB developers,

In 2.6.9, 'usb-storage' module depends on 'scsi_mod', but not 'sd_mod'.
This means that I have to load 'sd_mod' manually, or put something like
    alias block-major-8-* sd_mod
in /etc/modprobe.conf.

Is there reason why 'sd_mod' is not listed as one of dependant modules
for 'usb-storage'?

	Yours truly,
-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
