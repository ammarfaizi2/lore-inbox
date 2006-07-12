Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWGLS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWGLS4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWGLS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:56:44 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:22294 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750757AbWGLS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:56:43 -0400
X-IronPort-AV: i="4.06,236,1149490800"; 
   d="scan'208"; a="433961077:sNHT23448424"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Ingo Molnar <mingo@elte.hu>, Sean Hefty <sean.hefty@intel.com>,
       Zach Brown <zach.brown@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <20060712093820.GA9218@elte.hu>
	<20060712110955.GB18466@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 11:56:37 -0700
Message-ID: <aday7uywt22.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 18:56:40.0958 (UTC) FILETIME=[E92991E0:01C6A5E4]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Avoid bogus out out memory errors: fix sa_query to actually pass gfp_mask
 > supplied by the user to idr_pre_get.

Yes, this looks right to me.

 - R.
