Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267731AbUBTBxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267723AbUBTBxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:53:00 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:670 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S267731AbUBTBw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:52:58 -0500
Message-ID: <403566CA.8010907@cyberone.com.au>
Date: Fri, 20 Feb 2004 12:45:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] per process request limits (was Re: IO scheduler, queue
 depth, nr_requests)
References: <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au>
In-Reply-To: <40355F03.9030207@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Hi Miquel,
> Can you see if this patch helps you?
>

This patch isn't actually so good because it doesn't wake
a specific process when it gets below it's limit...

