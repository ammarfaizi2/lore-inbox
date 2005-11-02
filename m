Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVKBIeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVKBIeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVKBIeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:34:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28814 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932652AbVKBIeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:34:01 -0500
Date: Wed, 02 Nov 2005 17:33:08 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <436877DB.7020808@yahoo.com.au>
References: <1130917338.14475.133.camel@localhost> <436877DB.7020808@yahoo.com.au>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One other thing, if we decide to take the zones approach, it would have
> > no other side benefits for the kernel.  It would be for hotplug only and
> > I don't think even the large page users would get much benefit.  
> > 
> 
> Hugepage users? They can be satisfied with ZONE_REMOVABLE too. If you're
> talking about other higher-order users, I still think we can't guarantee
> past about order 1 or 2 with Mel's patch and they simply need to have
> some other ways to do things.

Hmmm. I don't see at this point.
Why do you think ZONE_REMOVABLE can satisfy for hugepage.
At leaset, my ZONE_REMOVABLE patch doesn't any concern about
fragmentation.

Bye.

-- 
Yasunori Goto 

