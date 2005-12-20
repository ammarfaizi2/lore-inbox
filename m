Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVLTTIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVLTTIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLTTIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:08:38 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12499 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750790AbVLTTIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:08:38 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
Date: Tue, 20 Dec 2005 19:08:24 +0000
Message-Id: <122020051908.25484.43A856A8000A6E600000638C220075894200009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Aug  4 2005)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, well, one of the larger drawbacks of 4KiB stacks is the inevitable
> flamewar, each time with /less/ data (this round I've seen none) supporting
> the need for larger stacks, into which all kinds of idiots* are suckered.

At the same time, I haven't seen any data showing what we gain by losing the 8K 
stack option.  Where are the links to posts where people are claiming en masse 
that 8K stacks are causing screwups, halting VM development etc.?

If 8K stacks are something that works, is not default, what do we gain by losing 
it in total? If people need ndiswrapper (I hate it as much as any one else , but come on 
for some people it's the only option) or any other functionality that requires 
bigger stack, let them choose it if they are ready to take whatever risks that come with it. 

To the ndiswrapper users - Do you guys have any real data showing 4K stacks 
result in problems for you? (Since it is dedicated 4K against shared 8K, it 
might as well not cause problems.) If you do then it's clear that 8K shared  
gives more room than 4k dedicated.

Parag
