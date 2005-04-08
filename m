Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVDHK03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVDHK03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVDHK0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:26:05 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:57487 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262793AbVDHKWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:22:48 -0400
Message-ID: <42565B70.2040400@yahoo.com.au>
Date: Fri, 08 Apr 2005 20:22:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de> <424928A1.8060400@yahoo.com.au> <4249F98D.9040706@yahoo.com.au> <20050408094557.GG22988@suse.de> <425654F5.70707@yahoo.com.au> <20050408100235.GI22988@suse.de>
In-Reply-To: <20050408100235.GI22988@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Apr 08 2005, Nick Piggin wrote:
> 

>>I guess this isn't a problem, as io contexts should be allocated
>>comparatively rarely. It would be possible to move it out of the
>>lock though if we really want to.
> 
> 
> Lets just keep it inside the lock, for the fast case it should just be
> an increment of the already existing io context.
> 

Sounds good.

-- 
SUSE Labs, Novell Inc.

