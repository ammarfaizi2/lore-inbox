Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWCPCzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWCPCzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWCPCzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:55:47 -0500
Received: from mx.pathscale.com ([64.160.42.68]:24453 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752006AbWCPCzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:55:46 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1142477579.6994.124.camel@localhost.localdomain>
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
Content-Type: text/plain
Date: Wed, 15 Mar 2006 18:56:13 -0800
Message-Id: <1142477774.6994.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 18:53 -0800, Bryan O'Sullivan wrote:

> This is what it looks like when I always call get_page in my nopage
> handler (after checking that the pfn is valid and pfn_to_page hasn't
> given me junk).

Ugh - I clicked on send too soon.  I think my next step will be to
figure out which vma is being cleaned up when this problem occurs first.

	<b

