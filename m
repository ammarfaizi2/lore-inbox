Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVLTTbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVLTTbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVLTTbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:31:05 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:25083 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750949AbVLTTbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:31:04 -0500
Date: Tue, 20 Dec 2005 11:25:00 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: <122020051908.25484.43A856A8000A6E600000638C220075894200009A9B9CD3040A029D0A05@comcast.net>
Message-ID: <Pine.LNX.4.62.0512201124050.11093@qynat.qvtvafvgr.pbz>
References: <122020051908.25484.43A856A8000A6E600000638C220075894200009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Parag Warudkar wrote:

>> Oh, well, one of the larger drawbacks of 4KiB stacks is the inevitable
>> flamewar, each time with /less/ data (this round I've seen none) supporting
>> the need for larger stacks, into which all kinds of idiots* are suckered.
>
> At the same time, I haven't seen any data showing what we gain by losing the 8K
> stack option.  Where are the links to posts where people are claiming en masse
> that 8K stacks are causing screwups, halting VM development etc.?

by goig to 4k stacks they are able to be allocated even when memory is 
badly fragmented, which is not the case while they are 8k.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

