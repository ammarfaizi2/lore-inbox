Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVJRWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVJRWgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJRWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:36:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54192 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932185AbVJRWgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:36:40 -0400
Subject: [PATCH 0/2] hugetlb: Demand faulting
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       William Irwin <wli@holomorphy.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 18 Oct 2005 17:36:20 -0500
Message-Id: <1129674980.8702.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Hugh and I have rolled these around the last few days and what we
have now should integrate properly and solve the outstanding truncation
issues.  We should be ready to re-insert these patches into -mm.

The old patch [1/3] remove get_user_pages_optimization is no longer
necessary.  We now have [1/2] "the fault handler" and [2/2] "overcommit
accounting check"
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

