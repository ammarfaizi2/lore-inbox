Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbULFGai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbULFGai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 01:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbULFGai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 01:30:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:49308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbULFGae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 01:30:34 -0500
Date: Sun, 5 Dec 2004 22:30:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: mef@CS.Princeton.EDU, linux-kernel@vger.kernel.org, riel@redhat.com,
       mason@suse.com, ckrm-tech@lists.sourceforge.net, llp@CS.Princeton.EDU,
       acb@CS.Princeton.EDU, mlhuang@CS.Princeton.EDU, smuir@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource
 Management
Message-Id: <20041205223014.79c9bf16.akpm@osdl.org>
In-Reply-To: <E1CaVM9-0005yy-00@w-gerrit.beaverton.ibm.com>
References: <20041203164034.2191957c.akpm@osdl.org>
	<E1CaVM9-0005yy-00@w-gerrit.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga <gh@us.ibm.com> wrote:
>
> So, Andrew, can you clarify how much we need to put in your hands, how
> well tested it needs to be and how clean and current the entire set needs
> to be before this is ready for -mm testing?

Well we can toss stuff into -mm any old time really.  Doing it too early
will cause rather a lot of difficulty and churn at both ends - working
against -mm can be an extra burden at times.

I'd say that it would be best to wait until the code is, in your opinion,
in a Linus-mergeable form.  Then after one lkml review round and any
subsequent rework we should be in good shape.
