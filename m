Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUGMWTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUGMWTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUGMWTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:19:47 -0400
Received: from holomorphy.com ([207.189.100.168]:22424 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267165AbUGMWSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:18:06 -0400
Date: Tue, 13 Jul 2004 15:17:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
Message-ID: <20040713221757.GK21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407132029540.8535-100000@localhost.localdomain> <40F447B8.5080208@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F447B8.5080208@colorfullife.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 10:36:08PM +0200, Manfred Spraul wrote:
> Thus I'd propose a quick fix (fail if there is a dtor - are there any 
> slab caches with dtors at all?) and in the long run slab_destroy should 
> be moved into the rcu callback.

Yes, ia32 pgd and pmd slabs have dtors.


-- wli
