Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbULFHlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbULFHlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 02:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULFHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 02:41:09 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:16000
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261343AbULFHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 02:41:08 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3 on PowerMac 8500/G3 - mostly OK(!)
Message-Id: <E1CbDUZ-0000td-00@penngrove.fdns.net>
Date: Sun, 05 Dec 2004 23:41:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'-rc3' fixed both long standing graphics bugs on an PowerMac 8500 with G3 
upgrade, which is a major improvement.  It corrects two bugs, one dating
back to 2.6.9-rc1 and the other, MUCH earlier than that, both affecting
framebuffer text consoles.  

I haven't run it long enough to judge stability, but so far so good.  

It has problems initializing a Gigafast WF741-UIC Wireless USB device.
But that device has had problems with vanilla i386 LINUX until 2.6.10-rc2
in any case.  So i'm not surprised or concerned that it doesn't work here
yet.  This is largely an FYI, as this hardware was purchased for a laptop
and was just put on the PPC for test purposes.

Thanks 'benh' (and whoever else worked on this), as this has been a long-
standing and frustration problem!
				   -- JM
