Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUEKDWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUEKDWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 23:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUEKDWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 23:22:44 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:12146 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261900AbUEKDWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 23:22:43 -0400
Message-ID: <40A04700.1060704@yahoo.com.au>
Date: Tue, 11 May 2004 13:22:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
References: <20040507093921.GD21109@suse.de> <200405072200.i47M0AF00868@unix-os.sc.intel.com> <20040510143024.GF14403@suse.de> <409F9510.9050001@yahoo.com.au> <20040510144454.GH14403@suse.de>
In-Reply-To: <20040510144454.GH14403@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 11 2004, Nick Piggin wrote:
> 

>>
>>While we're doing that can we drop the GFP_ATOMIC allocation
>>completely?
> 
> 
> Thought the same thing. But lets stick to single item tests first, then
> we can kill that double allocation after.
> 

That sounds like the best idea :)
