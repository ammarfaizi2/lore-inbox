Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVKGVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVKGVLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVKGVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:11:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49584 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964882AbVKGVLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:11:42 -0500
Subject: [RFC 0/2] Copy on write for hugetlbfs
From: Adam Litke <agl@us.ibm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
       hugh@veritas.com, rohit.seth@intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Nov 2005 15:10:41 -0600
Message-Id: <1131397841.25133.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches implement copy-on-write for hugetlbfs (thus
enabling MAP_PRIVATE mappings).  Patch 1/2 (previously posted by David
Gibson) contains a couple small fixes to the demand fault handler and
makes COW fit in nicely.  Patch 2/2 is the cow changes.  Comments?
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

