Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVIEVU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVIEVU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVIEVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:20:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48108 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932553AbVIEVU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:20:27 -0400
Date: Mon, 5 Sep 2005 22:20:26 +0100
From: viro@ZenIV.linux.org.uk
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.13-git5-bird2
Message-ID: <20050905212026.GL5155@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905164712.GI5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With several more patches (mostly - sparse regression fixing); same place,
ftp.linux.org.uk/pub/people/viro/{patch-2.6.13-git5-bird2.bz,patchset}

Added:
	* O4-dm9000		missed s/u32/pm_message_t/ (dm9000)
	* S20-wdt		__user annotations (booke_wdt.c)
	* S21-cx88		__user annotations (cx88-video.c)
	* S22-ac3200		iomem annotations (ac3200.c)
	* S23-forcedeth		__user annotations (forcedeth.c)
	* S24-proc		NULL noise removal (proc/task_mmu.c)
	* S25-page_alloc	missing prototype (mm/page_alloc.c)

Logs are on ftp.linux.org.uk/pub/people/viro/logs/*log18a (gcc and sparse).

Looking some more into Alexey's sunrpc patch, have not merged yet...
