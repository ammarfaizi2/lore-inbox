Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUBHBqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBHBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:46:35 -0500
Received: from dp.samba.org ([66.70.73.150]:35218 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261950AbUBHBqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:46:34 -0500
Date: Sun, 8 Feb 2004 12:41:41 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040208014141.GX19011@krispykreme>
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme> <40258F21.30209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40258F21.30209@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does active balancing still work? Ie. get two processes running on the
> same physical CPU and see if one is migrated away.

Both Ricks patch and your patch still have the active rebalance issue.

Martins patch doesnt, but that seems to be because it does absolutely no
rebalancing (all my runnable tasks are on one physical cpu) :)

Anton
