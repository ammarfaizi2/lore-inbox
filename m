Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbULOQM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbULOQM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULOQM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:12:29 -0500
Received: from aktion1.adns.de ([62.116.145.13]:27098 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S262374AbULOQMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:12:19 -0500
Message-ID: <41C062E4.3030906@asbest-online.de>
Date: Wed, 15 Dec 2004 17:14:28 +0100
From: Sven Krohlas <sven@asbest-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041213
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding schedular and slab allocation
References: <3bGLs-1dr-3@gated-at.bofh.it> <3bGLs-1dr-1@gated-at.bofh.it> <3bGVh-1jR-23@gated-at.bofh.it>
In-Reply-To: <3bGVh-1jR-23@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scan: smtp-vilter
X-SMTP-Vilter-Version: 1.1.4
X-SMTP-Vilter-Backend: vilter-clamd
X-SMTP-Vilter-Status: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Btw: is anybody working on the slab allocator as described in Bonwicks
>> 2001 paper?
> Linux already fronts the slab allocator with per-cpu pools.

Well, I haven't had such a deep look at the 2001 version (my topic was
the current implementation)...
I've seen the per-cpu pools. Bonwick talks in his paper of allocations in
guaranteed constant time (using vmem). Is this goal already achived in
Linux? There is a lock protecting the cache_chain, doesn't this hurt
scalability?

And what about the other improvements?

-vmem for allocating general resources
-A user-space implementation (well I know, that's a bit off topic here..)

Are they already implemented/is anybody working on this or are there
already known better solutions than Bonwicks suggestions?

Greetings,
Sven
