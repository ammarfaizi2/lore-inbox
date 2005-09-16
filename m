Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVIPMto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVIPMto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVIPMtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:49:43 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:64508 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1161068AbVIPMtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:49:43 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: Fix interface for memory hotplug in 2.6.13-mm3
Date: Fri, 16 Sep 2005 14:49:21 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20050916101541.D1B1.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20050916101541.D1B1.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509161449.21413.lion.vollnhals@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 September 2005 03:48, Yasunori Goto wrote:
> 
> Hi Andrew-san.
> 
> I found old unsuitable interfaces for memory hotplug in 2.6.13-mm3.
> 
> The third argument of sparse_add_one_section() was changed from mem_map
> to nr_pages. And the third argument of add/remove_memory() was removed.
> However, both still remain at a few place.
> 

Seems good to me.

Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>


-- 
Lion Vollnhals
