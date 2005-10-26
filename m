Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVJZPnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVJZPnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJZPnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:43:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50138 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964782AbVJZPnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:43:04 -0400
Message-ID: <435FA3FB.9030107@pobox.com>
Date: Wed, 26 Oct 2005 11:42:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill massive wireless-related log spam
References: <20051026042827.GA22836@havoc.gtf.org> <200510261704.15366.ak@suse.de>
In-Reply-To: <200510261704.15366.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 26 October 2005 06:28, Jeff Garzik wrote:
> 
> 
>>Change this to printing out the message once, per kernel boot.
> 
> 
> It doesn't do that. It prints it once every 2^32 calls. Also

...which is effectively one per kernel boot


> the ++ causes unnecessary dirty cache lines in normal operation.

Not a hot path operation by any stretch of the imagination, so that's fine.

	Jeff


