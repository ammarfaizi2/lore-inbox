Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUAYUZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUAYUXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:23:53 -0500
Received: from mx02.qsc.de ([213.148.130.14]:63702 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265242AbUAYUXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:23:04 -0500
Message-ID: <401425B6.4050701@trash.net>
Date: Sun, 25 Jan 2004 21:23:18 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: sebek64@post.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] IMQ port to 2.6
References: <20040125152419.GA3208@penguin.localdomain> <20040125.112542.10303353.davem@redhat.com>
In-Reply-To: <20040125.112542.10303353.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: sebek64@post.cz (Marcel Sebek)
>    Date: Sun, 25 Jan 2004 16:24:19 +0100
> 
>    I have ported IMQ driver from 2.4 to 2.6.2-rc1.
>    
>    Original version was from http://trash.net/~kaber/imq/.
>    
> Patrick, do you mind if I merge this 2.6.x port into my tree?
> 

Please don't. The imq device is buggy, it crashes when used
for ingress and egress at the same time, additionally it's
unmaintained since one or two years. The lartc list is full
of bugreports. Some users that depend on the functionality
are working on a better implementation, I'd suggest to wait
until then.

Best regards,
Patrick

