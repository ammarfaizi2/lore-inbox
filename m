Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUKLAQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUKLAQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKLAL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:11:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:433 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUKLAI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:08:56 -0500
Date: Thu, 11 Nov 2004 16:11:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Michael Heyse <mhk@designassembly.de>, Jeff Garzik <jgarzik@pobox.com>,
       Mirko Lindner <mlindner@syskonnect.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] (0/23) sk98 driver fixes and enhancements
Message-Id: <20041111161124.34ccb1e6@zqx3.pdx.osdl.net>
In-Reply-To: <4192C60A.1050205@designassembly.de>
References: <4192C60A.1050205@designassembly.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of patches to merge some of the new SysKonnect
code with existing 2.6 driver and fix several bugs. 

1: 	Remove explicit module refcounting (bug) 
2: 	Make OnesHash table local constant.
3: 	proc print interface cleanup
4: 	Use netdev_priv
5:  	Use module_param_array instead of deprecated MODULE_PARM
6: 	Add netpoll controller support
7:      Basic ethtool support
8:      Ethtool support for LED blinking
9: 	Ethtool pause param support
10:	Cleanup
11:	Fix boards_found count
12:	Add MODULE_VERSION
13:	Handle ring full condition properly (bug)
14:	Get rid of obfuscation irqreturn_t
15:	Rearrange functions to match SysKonnect code
16:	More efficient OsGetTime
17:	Enable high dma and lockless transmit
18:	reorganize pci_device table
19:	Do initialization better
20:	Ethtool tx & receive checksum efficiently
21:	Tx ring management improvements
22:	Cleanup the code under DIAG_SUPPORT
23:	Eliminate Pnmi scratchpad common

To spare people's mailbox the individual patches won't go to LKML just to netdev.
