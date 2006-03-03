Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWCCPQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWCCPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCCPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:16:26 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:53687 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751481AbWCCPQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:16:25 -0500
From: Jiri Slaby <jirislaby@gmail.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm1 ext3 filesystem corruption
Message-Id: <E1FFC0m-00068j-00@decibel.fi.muni.cz>
Date: Fri, 03 Mar 2006 16:16:08 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
>One of my 2.6.15-rc5-mm1 test boxes just crashed and caused filesystem 
>corruption on its ext3 / filesystem.
>
>The crash left these bits in syslog before automatically remounting the 
>filesystem read-only and crashing the X server that was displaying the full 
>message:
>
>[<b01aa074>] __ext3_journal_stop+0x24/0x50
>[<b01a3cf2>] ext3_delete_inode+0xb2/0x100
>[<b01770c3>] dput+0x23/0x180
>[<b017b022>] mntput_no_expire+0x22/0x90
>[<b016fadf>] sys_link+0x2f/0x40
>[<b0102e13>] sysenter_past_esp+0x54/0x75
Could you try -mm2, if this disappeared?

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
