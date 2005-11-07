Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbVKGWhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbVKGWhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbVKGWhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:37:24 -0500
Received: from mail.gmx.de ([213.165.64.20]:56261 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965289AbVKGWhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:37:23 -0500
X-Authenticated: #20450766
Date: Mon, 7 Nov 2005 23:37:33 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: block requests from user space?
Message-ID: <Pine.LNX.4.60.0511072259520.4791@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

It looks like there's no possibility atm to inject block requests from 
user space directly into device's queues? There's an cdrom ioctl, maybe 
scsi, but nothing generic for arbitrary request queue. Or have I missed 
something?

If such a possibility would be considered meaningful, given a general 
dislike to ioctl's, would it be a right idea to implement it as a 
filesystem with an inode for each disk / cdrom / loop / tape / ...?

Thanks
Guennadi
---
Guennadi Liakhovetski
