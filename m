Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTE1P2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbTE1P2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:28:11 -0400
Received: from motherfish-II.xiph.org ([198.136.36.245]:22941 "EHLO
	motherfish-II.xiph.org") by vger.kernel.org with ESMTP
	id S264767AbTE1P2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:28:10 -0400
Date: Wed, 28 May 2003 11:41:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Orinoco_cs module won't unload in 2.5.70
Message-ID: <20030528154125.GA1289@motherfish-II.xiph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: greg@xiph.org (Gregory Maxwell)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.70 (and 2.5.69-mm8 before it) on my Dell Latitude C840 is
unable to unload the orinoco_cs driver.

I get the following message over and over again while the rmmod hangs:
unregister_netdevice: waiting for eth1 to become free. Usage count = 1

Even after ifconfig downing the interface..

This is quite annoying because the driver doesn't survive suspend and I
can't cleanly shutdown. :)

Suggestions?
