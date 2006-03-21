Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWCUKhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCUKhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWCUKhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:37:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40395
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932409AbWCUKhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:37:15 -0500
Date: Tue, 21 Mar 2006 02:37:05 -0800 (PST)
Message-Id: <20060321.023705.26111240.davem@davemloft.net>
To: hawk@diku.dk
Cc: dipankar@in.ibm.com, Robert.Olsson@data.slu.se, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
	<20060320220956.GA24792@in.ibm.com>
	<Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <hawk@diku.dk>
Date: Tue, 21 Mar 2006 11:29:16 +0100 (CET)

> Do you have an explaination of the syslog listing, showing yet another 
> code path sleeping/failing??.  In the fib_trie code. (I have recorded 12 
> of these).

If you happen to have the IP_ROUTE_MULTIPATH_CACHED config option
enabled in your kernels, please turn it off and retest.
