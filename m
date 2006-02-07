Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWBGABv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWBGABv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWBGABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:01:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35754 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964883AbWBGABt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:01:49 -0500
Message-ID: <43E7E38D.4060007@jp.fujitsu.com>
Date: Tue, 07 Feb 2006 09:02:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unify pfn_to_page [25/25] sparc64 pfn_to_page/page_to_pfn
References: <43E731B5.9050407@jp.fujitsu.com> <20060206.132434.130599234.davem@davemloft.net>
In-Reply-To: <20060206.132434.130599234.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> We did not want these inlined on sparc64 for a good reason.
> The pointer arithmatic gets expanded to many additions,
> subtractions, and shifts, and I felt it too much to inline.
> 
Okay.
> If you want to consolidate all of the implementations, that's
> fine, but please keep the option of not inlining these two
> routines.
> 

I'll do (and CC to each arch's maintainer in next post)

Thanks,
-- Kame


