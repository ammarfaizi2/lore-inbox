Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVHHUVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVHHUVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHHUVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:21:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932255AbVHHUVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:21:44 -0400
Message-Id: <20050808201416.450491000@jumble.boston.redhat.com>
Date: Mon, 08 Aug 2005 16:14:16 -0400
From: Rik van Riel <riel@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 0/3] non-resident page tracking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implement non-resident page tracking, which is needed
infrastructure for advanced page replacement algorithms like CART
and CLOCK-Pro.

The patches have been tested, but could use some eyeballs.  In
particular, I do not know if the chosen hash function gives a good
spread between the hash buckets.

Note that these patches are not very useful by themselves, I still
need to implement CLOCK-Pro on top of them.  For more information
please see the linux-mm wiki:

	http://linux-mm.org/wiki/AdvancedPageReplacement

-- 
All Rights Reversed
