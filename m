Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVD0HM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVD0HM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVD0HMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:12:25 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43735 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261757AbVD0HJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 03:09:09 -0400
Message-ID: <426F3BC1.2060408@jp.fujitsu.com>
Date: Wed, 27 Apr 2005 16:14:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] counting bounce buffer in vmstat
References: <426F3445.9060701@jp.fujitsu.com> <20050426234725.1ed66aff.akpm@osdl.org>
In-Reply-To: <20050426234725.1ed66aff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> That's not really right.
> 
> There are two functions: get_page_state() and get_full_page_state(). 
> get_page_state() only gets those fields up to and including
> GET_PAGE_STATE_LAST.  The way you have the code laid out there implies that
> get_page_state() also calculates the total nr_bounce, only it doesn't.
> 
> I'll fix it up.
> 

Oh, I misunderstood that.

Thank you.

-- Kame


