Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUC1R31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUC1R31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:29:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262132AbUC1R3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:29:24 -0500
Message-ID: <40670B63.8040704@pobox.com>
Date: Sun, 28 Mar 2004 12:29:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040327170257.24c82915.akpm@osdl.org> <406625D4.7090605@pobox.com> <20040328135907.GC24370@suse.de>
In-Reply-To: <20040328135907.GC24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Mar 27 2004, Jeff Garzik wrote:
> 
>>"IOPs" are what make a lot of storage peeps excited these days, so they 
>>are being pushed in a low-latency direction anyway.
> 
> 
> IOPS says nothing about latency, it's still 100% throughput oriented.


In order to achieve a large IOPs number, one must sent a ton of small 
requests.  Per-request latency as well as overall throughput is a factor.

	Jeff



