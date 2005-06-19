Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVFSCgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVFSCgo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 22:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVFSCgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 22:36:44 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:53180 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261387AbVFSCgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 22:36:42 -0400
Date: Sat, 18 Jun 2005 19:36:36 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: aquynh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12
Message-Id: <20050618193636.70ab8b05.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.62.0506181847550.11617@qynat.qvtvafvgr.pbz>
References: <200506182005.28254.nick@linicks.net>
	<9a8748490506181233675f2fd5@mail.gmail.com>
	<9cde8bff0506181839d41aab3@mail.gmail.com>
	<Pine.LNX.4.62.0506181847550.11617@qynat.qvtvafvgr.pbz>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005 18:48:59 -0700 (PDT) David Lang wrote:

| On Sat, 18 Jun 2005, aq wrote:
| 
| > the version number is a little bit confused here: if I want to upgrade
| > from for example 2.6.11.5 to 2.6.12, which patch should I get?
| 
| you reverse the 2.6.11 -> 2.6.11.5 patch to get back to a vinilla 2.6.11
| then you apply the 2.6.11->2.6.12 patch.

Hrm, I expected ketchup to be able to handle that already.
Does it not?

So you can do the above by hand or you can use scripts/patch-kernel
in the kernel tree (but not in the 2.6.11 tree, just in the
2.6.12 tree or get it from here:
http://www.xenotime.net/linux/scripts/patch-kernel )
to do the reverse-patch and apply-patch.
However, patch-kernel won't download the 2.6.11.12 patch for you.


| David Lang
| 
| > anybody knows if Matt will upgrade his ketchup for the new versioning
| > system soon? otherwise, I might spend some time to hack it up.
| >
| > regards,
| > aq



---
~Randy
