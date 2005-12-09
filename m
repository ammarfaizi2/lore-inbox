Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVLIUi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVLIUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLIUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:38:27 -0500
Received: from gold.veritas.com ([143.127.12.110]:12562 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932450AbVLIUi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:38:27 -0500
Date: Fri, 9 Dec 2005 20:37:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mark Rustad <mrustad@mac.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix
 coding style
In-Reply-To: <DB1A6A43-DA12-4C5B-B195-5C01DED4CF3E@mac.com>
Message-ID: <Pine.LNX.4.61.0512092034510.28318@goblin.wat.veritas.com>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
 <1134148609.30856.22.camel@localhost> <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com>
 <1134151696.3278.2.camel@localhost> <DB1A6A43-DA12-4C5B-B195-5C01DED4CF3E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Dec 2005 20:37:41.0446 (UTC) FILETIME=[66AE6660:01C5FD00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Mark Rustad wrote:
> 
> If hugetlbfs could be guaranteed to provide contiguous memory for a file, that
> could be used in this application. We used to use remap_pfn_range in our
> driver, but recent changes there made that not work for this application, so I

You're not the only one to have trouble with recent remap_pfn_range changes.
Would you let us know what you were doing, that you can no longer do?
Some of the change may need to be reverted.

Hugh
