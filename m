Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263405AbUCPG24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbUCPG24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:28:56 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:14550 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263405AbUCPG2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:28:55 -0500
Message-ID: <40569E68.2040806@cyberone.com.au>
Date: Tue, 16 Mar 2004 17:27:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
References: <20040315222419.GM30940@dualathlon.random> <Pine.LNX.4.44.0403151737380.12895-100000@chimarrao.boston.redhat.com> <20040315233205.GO30940@dualathlon.random>
In-Reply-To: <20040315233205.GO30940@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>
>I argue those scalability benefits of the locks, on a 32G machine or on
>a 1G machine those locks benefits are near zero. The only significant
>benefit is in terms of computational complexity of the normal-zone
>allocations, where we'll only walk on the zone-normal and zone-dma
>pages.
>
>

Out of interest, are there workloads on 8 and 16-way UMA systems
that have lru_lock scalability problems in 2.6? Anyone know?


