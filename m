Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTK3HR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTK3HR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:17:59 -0500
Received: from ppp-RAS1-2-81.dialup.eol.ca ([64.56.225.81]:18304 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S264873AbTK3HR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:17:58 -0500
Date: Sun, 30 Nov 2003 02:17:57 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130071757.GA9835@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have modem working in 2.6.0-test11?

I have external modem connected to /dev/ttyS0 (COM1).  Kernel
2.6.0-test11 give me
    Failed to open /dev/modem: No such device
where /dev/modem is symlink to /dev/ttyS0.  I've looked at
/proc/interrupts and /proc/ioports, and I can't find any mention of
irq=4 or io=3f8 which are the normal settings that I use.

No problem in kernel-2.4.23, though.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
