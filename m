Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVLHT0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVLHT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLHT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:26:25 -0500
Received: from [194.90.237.34] ([194.90.237.34]:20533 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S932218AbVLHT0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:26:24 -0500
Date: Thu, 8 Dec 2005 21:29:18 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051208192918.GC13886@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> Many would be pleased if we could manage without set_page_dirty_lock.

Yes, it forces me to bounce a work into a queue from the interrupt.
Thanks!

-- 
MST
