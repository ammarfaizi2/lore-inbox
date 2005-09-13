Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVIMXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVIMXwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIMXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:52:39 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61649 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751165AbVIMXwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:52:38 -0400
Message-ID: <432765FC.7010204@jp.fujitsu.com>
Date: Wed, 14 Sep 2005 08:51:24 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
References: <43246267.mailL4R11PXCB@suse.de> <200509131147.42140.ak@suse.de> <20050913031540.0c732284.akpm@osdl.org> <200509131332.17244.ak@suse.de> <Pine.LNX.4.61.0509131407580.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509131407580.3743@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
>>Kamezawa-san, can you please explain why exactly you did that change?
> 
> 
> Probably because it triggers this check:
> 
> #if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
> #error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
> #endif
> 
Yes, it was for this.
If still ZONES_WIDTH = ZONES_SHIFT =2, I have no problem.

Thanks,
-- Kame

> bye, Roman
> 


