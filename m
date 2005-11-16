Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVKPEFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVKPEFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVKPEFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:05:13 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:18347 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S965241AbVKPEFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:05:11 -0500
Date: Tue, 15 Nov 2005 23:05:19 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0511152248070.27630@lancer.cnet.absolutedigital.net>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Alex Davis wrote:

> Could someone either list or post a link to someplace that lists
> all the advantages of 4K stacks? 

See the help text for the option under the kernel configurator...

or <http://lwn.net/Articles/84583/>

To summarize: it allows for more processes/threads (each process/thread 
requires a kernel stack) and it makes it easier for the VM subsystem to 
allocate larger than order 0 (4k) memory segments (i.e. it will be easier 
to find contiguous free blocks).

HTH,
-cp

-- 
Phishing, pharming; n.: Ways to obtain phood. -- The Devil's Infosec Dictionary

