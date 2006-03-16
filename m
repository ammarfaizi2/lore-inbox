Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752218AbWCPHZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbWCPHZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbWCPHZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:25:46 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:45080 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1752215AbWCPHZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:25:45 -0500
X-IronPort-AV: i="4.02,196,1139212800"; 
   d="scan'208"; a="314831757:sNHT23381224"
To: Andrew Morton <akpm@osdl.org>
Cc: bos@pathscale.com, Hugh@veritas.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
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
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
	<20060315221716.19a92762.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 23:25:41 -0800
In-Reply-To: <20060315221716.19a92762.akpm@osdl.org> (Andrew Morton's message of "Wed, 15 Mar 2006 22:17:16 -0800")
Message-ID: <ada4q1yu9ze.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 07:25:43.0706 (UTC) FILETIME=[D5F86FA0:01C648CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> vm_insert_page() mucks around with rmap-named functions
    Andrew> which don't actually do rmap and sports
    Andrew> apparently-incorrect comments wrt PageReserved().  I don't
    Andrew> know how well-cared-for it is...

Linus just added vm_insert_page() a few months ago.  Has it already bit-rotted?

 - R.
