Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVCGXEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVCGXEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVCGXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:01:46 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:5584 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261783AbVCGWaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:30:17 -0500
Date: Mon, 7 Mar 2005 14:29:52 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>,
       <reiserfs-list@namesys.com>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync
 option?
In-Reply-To: <1110216555.28860.74.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.44.0503071426070.7096-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FiSC can still get those warnings with hdparm -W 0, or with a simple
ramdisk that serves the disk requests whenever they are submitted.

Thanks,
-Junfeng

On Mon, 7 Mar 2005, Alan Cox wrote:

> The IDE layer default is still unfortunately broken and leaves write
> caching enabled. Turn it off with hdparm.
>

