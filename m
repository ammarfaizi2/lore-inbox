Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269899AbUJHAqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269899AbUJHAqC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269988AbUJHAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:41:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:3230 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269949AbUJHAiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:38:08 -0400
Date: Fri, 08 Oct 2004 09:43:40 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [PATCH] no buddy bitmap patch : for ia64 [2/2]
In-reply-to: <1097163793.3625.47.camel@localhost>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <4165E2BC.3070906@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <4165399D.7010600@jp.fujitsu.com>
 <1097163793.3625.47.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> The real way to do this is to put it in a Kconfig file.  
> 
> something like:
> 
> config HOLES_IN_ZONE
> 	bool
> 	depends on VIRTUAL_MEM_MAP
> 
> right below where 'config VIRTUAL_MEM_MAP' is defined.  That way, if any
> other architectures need it, they alter their Kconfig files instead of
> headers.  Also, it leaves the possibility of having an arch-independent
> Kconfig file for memory-related options which I'd like to do in the
> future.
> 
Ok, it looks better. I'll move it.
Updated version will be posted in a day.


Kame <kamezawa.hiroyu@jp.fujitsu.com>

