Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbWCPUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWCPUnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWCPUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:43:46 -0500
Received: from mx.pathscale.com ([64.160.42.68]:56279 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932731AbWCPUnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:43:45 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       rdreier@cisco.com, hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603161234160.3618@g5.osdl.org>
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
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
	 <1142538765.10950.16.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
	 <Pine.LNX.4.64.0603161234160.3618@g5.osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 16 Mar 2006 12:43:40 -0800
Message-Id: <1142541820.10950.18.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 12:35 -0800, Linus Torvalds wrote:

> The alternative is to always allocate the pages one by one ("order-0"), 
> and do get_page() when you return them in the ->nopage handler. That will 
> work with any kernel, so it has the simplicity thing going for it.

Thanks.  That's a very useful suggestion.

	<b

