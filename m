Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTEFPZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTEFPZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:25:29 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:7071 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263806AbTEFPZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:25:28 -0400
Message-ID: <3EB7D6BD.6040101@colorfullife.com>
Date: Tue, 06 May 2003 17:37:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: initcall kmem_cache cpu 1 oops
References: <Pine.LNX.4.44.0305061319190.1821-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0305061319190.1821-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bug in slab - it should switch to g_cpucache_up==FULL at the end 
of kmem_cache_sizes_init().

--
    Manfred

