Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWAGHrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWAGHrD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWAGHrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:47:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47530
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030348AbWAGHq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:46:59 -0500
Date: Fri, 06 Jan 2006 23:44:40 -0800 (PST)
Message-Id: <20060106.234440.53993868.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: ak@suse.de, paulmck@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43BF6F0B.4060108@cosmosbay.com>
References: <20060106.161721.124249301.davem@davemloft.net>
	<200601070209.02157.ak@suse.de>
	<43BF6F0B.4060108@cosmosbay.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Sat, 07 Jan 2006 08:34:35 +0100

> I agree, I do use a hashed spinlock array on my local tree for TCP,
> mainly to reduce the hash table size by a 2 factor.

So what do you think about going to a single spinlock for the
routing cache?
