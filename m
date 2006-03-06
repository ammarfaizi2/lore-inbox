Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWCFUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCFUiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCFUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:38:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19842
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932260AbWCFUiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:38:51 -0500
Date: Mon, 06 Mar 2006 12:39:04 -0800 (PST)
Message-Id: <20060306.123904.35238417.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060305113847.GE21751@in.ibm.com>
References: <20060305070537.GB21751@in.ibm.com>
	<20060304.233725.49897411.davem@davemloft.net>
	<20060305113847.GE21751@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Sun, 5 Mar 2006 17:08:47 +0530

> Great. I look forward to hearing from you about the results
> with your test case.

It works quite fine so far, I haven't seen the filp exhaustion
nor a highly fragmented filp SLAB.

Instead, I'm not hitting other bugs that are of my own doing
on Niagara, which is what I wanted to accomplish with these
stress tests in the first place :-)

I think we should seriously consider these patches for 2.6.16
