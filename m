Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTJZKgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTJZKgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:36:48 -0500
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:22721
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262848AbTJZKgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:36:47 -0500
Message-ID: <3F9BA3BB.6030502@kolivas.org>
Date: Sun, 26 Oct 2003 21:36:43 +1100
From: Con Kolivas <conman@kolivas.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031018
X-Accept-Language: en-au, en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
References: <200310232337.50538.kernel@kolivas.org> <8720000.1066920153@[10.10.2.4]> <200310240103.19336.kernel@kolivas.org> <200310251658.23070.kernel@kolivas.org> <3F9BAE6F.5070009@cyberone.com.au>
In-Reply-To: <3F9BAE6F.5070009@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> Hi Con,
> If this indeed makes VM behaviour better, why not just merge the 
> calculation
> with the swap_tendancy calculation and leave vm_swappiness there as a 
> tunable?

Because the whole point of it is to remove the tunable and make it auto 
tuning. We could do away with the vm_swappiness variable altogether too 
(which I would actually prefer to do) but this leaves it intact to see 
what the vm is doing.

Con

