Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVKEE6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVKEE6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVKEE6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:58:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:16573 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751208AbVKEE6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:58:33 -0500
Message-ID: <436C3BF7.1080906@pobox.com>
Date: Fri, 04 Nov 2005 23:58:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill 8139too kernel thread (sorta)
References: <20051031130255.GA26626@havoc.gtf.org> <E1EWgcG-0001dZ-00@gondolin.me.apana.org.au> <20051031211143.GA6409@gondor.apana.org.au> <436C2B47.3030505@pobox.com> <20051105042008.GA25823@gondor.apana.org.au>
In-Reply-To: <20051105042008.GA25823@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> My only concern is the potential for starvation here should we fail
> to obtain the RTNL.  Since any local user can hold the RTNL by issuing
> rtnetlink requests, it is theoretically possible for the rtl8139 work
> to be delayed indefinitely.

Yes, but highly unlikely, for very few users, with the negative effects 
negligible.

	Jeff


