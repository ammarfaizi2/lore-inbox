Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUHUOBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUHUOBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUHUOBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:01:48 -0400
Received: from main.gmane.org ([80.91.224.249]:21410 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266149AbUHUOBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:01:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karl Vogel <karl.vogel@seagha.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
Date: Sat, 21 Aug 2004 16:02:18 +0200
Message-ID: <cg7kk7$5rd$1@sea.gmane.org>
References: <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d51a4788e.kabel.telenet.be
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

preemption latency trace v1.0.1
-------------------------------
 latency: 408 us, entries: 2273 (2273)
    -----------------
    | task: ksoftirqd/0/2, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: netif_receive_skb+0x74/0x1f0
 => ended at:   netif_receive_skb+0x171/0x1f0
=======>

This one is hard to trim to post here, so full trace is posted on:
  http://users.telenet.be/kvogel/network.txt

.config at:
  http://users.telenet.be/kvogel/config.txt




