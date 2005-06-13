Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVFMKTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVFMKTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVFMKTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:19:55 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:62542 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261459AbVFMKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:19:53 -0400
Message-ID: <42AD5DC6.6090205@yahoo.com.au>
Date: Mon, 13 Jun 2005 20:19:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] blkstat
References: <42AD55FA.50109@yahoo.com.au> <200506131954.45361.kernel@kolivas.org> <42AD59A9.3030404@yahoo.com.au> <200506132005.40846.kernel@kolivas.org>
In-Reply-To: <200506132005.40846.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Mon, 13 Jun 2005 20:02, Nick Piggin wrote:
> 

>>The problem with that is that it does not give you a % idle
>>figure on the block device, so you basically can't see if
>>the device is becoming a bottleneck.
> 
> 
> I've often wondered how iostat gives a %busy figure and whether this 
> translated accurately without further info from the kernel.
> 
> 

Oh, it does havea "%util" in its extended stats. Sorry I missed
that so you might be right.

Hmm, so I guess it uses io_ticks and that does appear to give
the valid measure. I'll have a think about that - perhaps there
is still a place for the split read/write statistics I'm using...

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
