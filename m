Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWBJBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWBJBTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWBJBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:19:43 -0500
Received: from mail.dvmed.net ([216.237.124.58]:2747 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750985AbWBJBTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:19:42 -0500
Message-ID: <43EBEA26.8000709@pobox.com>
Date: Thu, 09 Feb 2006 20:19:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kill not-so-popular simple flag testing macros
References: <20060208085728.GA21065@htj.dyndns.org> <43EB8D2C.6020708@pobox.com> <43EBDC70.6050302@gmail.com>
In-Reply-To: <43EBDC70.6050302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > The code he was talking about looks
	like. > > if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER) { Yes, I
	certainly agree you don't want to test the same variable multiple
	times, if you are just testing bits in the same variable. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> The code he was talking about looks like.
> 
> if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER) {


Yes, I certainly agree you don't want to test the same variable multiple 
times, if you are just testing bits in the same variable.

	Jeff


