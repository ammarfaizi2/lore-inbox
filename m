Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVIHRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVIHRUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVIHRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:20:05 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:26644 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964869AbVIHRUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=l4lP934oY0uqzUzAqUI5tAJ68XPrDJh0E8sOjxrmMucJS0Nnf1ZxRMQpRon3URcAt1mIQwkRHk//Wszu91KPN2h5YEXjw1b+l8u45GM6Hl2jT4x4kTBxpUYnaX7wlYZKqiH//mk3I5wY/9TTaTmxEwUYknph1jMAw/30j/SXZpw=
Message-ID: <432072C5.8020200@gmail.com>
Date: Thu, 08 Sep 2005 19:20:05 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050823)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

I found a problem regarding to multi device support (Linux software Raid).

The problem first appears now in 2.6.13-mm2, that the kernel didn't initialize the md devices.

2.6.13-mm1 works very well, and everything is okay.

Also one strange thing I found was that my SATA devices were initialized a-sync/disordered e.g

SATA1 with one hdd then something like USB and IPv4 and such and at least SATA3: with 2nd hdd.
That I've never seen this order init order before. Seems to be mixed all around.

I tried irqpoll,pci=routeirq with no success.

I can't provide some logs, because I can't grep the dmesg since it doesn't boot.

There are changes in libata driver for sata_nv? Or md driver changes that cause that?


Thanks

Best regards

--
Michael Thonke

