Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUKSWHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUKSWHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKSWFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:05:16 -0500
Received: from dp.samba.org ([66.70.73.150]:1753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261649AbUKSWEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:04:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16798.28061.485747.492855@samba.org>
Date: Sat, 20 Nov 2004 09:03:09 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419E1297.4080400@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > Is this an fsync intensive benchmark?  If no, could you try with 
 > reiser4?  If yes, you might as well wait for us to optimize fsync first 
 > in reiser4.

In the configuration I was running there are no fsync calls.

I'll have a go with reiser4 soon and let you know how it goes. I'm
also working on a new version of dbench that will better simulate the
filesystem access patterns of Samba4.

Cheers, Tridge
