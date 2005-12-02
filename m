Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVLBM7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLBM7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLBM7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:59:18 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:18498 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbVLBM7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:59:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eX3B/dK0bCtsEwikLMPNGoATSnZW5UQ+NCwg4TOWX7BnZJpxjowWMmx3l3+u8pF4qApkDtz8LTz8otI1o1B2pT5EW+8NQvNtERG4aEpQPl6UqSK9YLfhN6/PJzYlwuKBA4b2pt4V/vGfTkfx/twvzDOkhsTvO0vIEU7DCzIzNSw=
Message-ID: <4390451F.9020903@gmail.com>
Date: Fri, 02 Dec 2005 21:59:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yanggun <yang.geum.seok@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 + SATAII150 TX2Plus does not recognize
References: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>	 <43902A52.9040909@gmail.com> <ee0ae26a0512020436w2c000a5dq@mail.gmail.com>
In-Reply-To: <ee0ae26a0512020436w2c000a5dq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yanggun wrote:
> thanks.
> 
> but sata_promise driver not seem to support hot-swap. As following
> message is said, it becomes block. Even if use irqpoll option, result
> is same.
> 
> I want to use hot-swap.
> 

Yeap, the standard doesn't support hot-swap yet.  I think either you 
gotta stay with 2.6.13 for the time being or wait for promise to update 
their driver.

-- 
tejun
