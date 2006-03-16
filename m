Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWCPChb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWCPChb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWCPCha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:37:30 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:60351 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751611AbWCPCha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:37:30 -0500
X-IronPort-AV: i="4.02,196,1139212800"; 
   d="scan'208"; a="1785368208:sNHT30133700"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 18:37:23 -0800
In-Reply-To: <1142475069.6994.114.camel@localhost.localdomain> (Bryan O'Sullivan's message of "Wed, 15 Mar 2006 18:11:09 -0800")
Message-ID: <adaslpjt8rg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 02:37:25.0050 (UTC) FILETIME=[8F2B01A0:01C648A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I think you should always be doing a get_page().

    Bryan> Yeah.  I think so too, but when I do it, I get an oops.

Hmm, looking at that oops might help debug your problem.

 - R.
