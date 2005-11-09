Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVKIX3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVKIX3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVKIX3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:29:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7347 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750987AbVKIX3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:29:40 -0500
Subject: [PATCH 0/4] hugetlb: copy on write
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, wli@holomorphy.com,
       hugh@veritas.com, rohit.seth@intel.com, kenneth.w.chen@intel.com,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 09 Nov 2005 17:28:45 -0600
Message-Id: <1131578925.28383.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the patches I sent on Nov 7th.  I've broken them out
as requested.  Comments (especially on the copy-on-write portion)
appreciated.  Does anyone have a fundamental objection to moving forward
with these?

remove-dup-isize-check - Remove duplicated i_size truncation race check
rename-find_lock_huge_page - Switch to a more appropriate name
hugetlb_no_page - Mild reorg to support multiple fault types
htlb-cow - Copy on write support

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

