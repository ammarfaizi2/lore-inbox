Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWDMOSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWDMOSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWDMOSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:18:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29343 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964922AbWDMOSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:18:17 -0400
Date: Thu, 13 Apr 2006 16:17:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Keith Owens <kaos@sgi.com>
cc: Nathan Scott <nathans@sgi.com>, dgc@melbourne.sgi.com,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com
Subject: Re: 2.6.17-rc1 did break XFS 
In-Reply-To: <9020.1144920230@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0604131615510.17374@yvahk01.tjqt.qr>
References: <9020.1144920230@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>notifier_chain_register() is running the existing chain to find the
>place where XFS needs to be inserted, and the existing chain is
>corrupt.  Probably not an XFS problem.
>
Aye. I booted 2.6.17-rc1 for some minutes to test CSCAN - root filesystem 
is XFS - and did not have any such early oops. Since `updatedb` happened to 
run automatically by cron just after I started that laptop, I also would 
not say it being an XFS problem. I do use VMSPLIT_3G_OPT however.


Jan Engelhardt
-- 
