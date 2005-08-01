Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVHAUmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVHAUmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVHAUjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:39:37 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41442 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261244AbVHAUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:36:56 -0400
Message-ID: <42EE87DF.1080508@pobox.com>
Date: Mon, 01 Aug 2005 16:36:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <20050801203228.GS22569@suse.de>
In-Reply-To: <20050801203228.GS22569@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Oh, and forget TCQ. It's a completely worthless technology inherited
> from PATA,

Agreed.

There are a few controllers where we may -eventually- add TCQ support, 
controllers that do 100% of TCQ in hardware.  But that's so far down the 
priority list, it's below just about everything else.

There may just be little motivation to -ever- support TCQ, even when 
libata is the 'main' IDE driver, sometime in the future.

I give an outline of queueing stuff at

	http://linux.yyz.us/sata/software-status.html#tcq

Regards,

	Jeff


