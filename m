Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWBHHPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWBHHPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBHHO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:14:57 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52364 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161056AbWBHHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:14:54 -0500
Message-ID: <43E99ABE.8090301@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 16:16:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle McMartin <kyle@mcmartin.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       grundler@parisc-linux.org
Subject: Re: [PATCH] unify pfn_to_page take 2 [16/25] parisc funcs
References: <43E98C73.2050903@jp.fujitsu.com> <20060208070758.GB21184@quicksilver.road.mcmartin.ca>
In-Reply-To: <20060208070758.GB21184@quicksilver.road.mcmartin.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin wrote:
> ACK... Looks fine to me. 
Thanks!
> Maybe the BUG_ON(zone == NULL) in page_to_pfn might be worth keeping? 
> 
placeing BUG_ON(zone == NULL) in page_zone() seems better to me.

But can it happen ??

Regards,
-- Kame



