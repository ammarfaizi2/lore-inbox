Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUL3KV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUL3KV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 05:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUL3KV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 05:21:57 -0500
Received: from mail.linicks.net ([217.204.244.146]:1408 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261597AbUL3KVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 05:21:55 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Date: Thu, 30 Dec 2004 10:21:54 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412301021.54043.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All of them have in common the notice of some process having
>
> "exited with preempt_count 1"
>
> and all of them happened within three hours -- this is the first time
> that a mainline kernel has been behaving so consistently unstable for
> me, in fact.

Yes, I got exactly the same - hard locked, nothing in logs.

I got this from screen:

kswapd exited with prempt-count 1
Kernel Panic - not syncing: fatal exception in interrupt.

My box has one IDE drive... and is gateway for my LAN using IPTABLES/NAT/MASQ.

The crash happened everytime I finished playing quake2 and quit the client.

I have gone back to 2.6.4 at the moment - the only kernel I can get to run 
24/7/365 without a kswapd oops.

I am still sussing why/wtf.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
