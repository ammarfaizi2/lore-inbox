Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTLIENM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLIENM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:13:12 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:21154 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262775AbTLIENK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:13:10 -0500
Message-ID: <3FD54BCE.7060804@charter.net>
Date: Mon, 08 Dec 2003 20:13:02 -0800
From: coderman <coderman@charter.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA on-chip RNG and crypto...
References: <3FD50CD6.3070808@pobox.com>
In-Reply-To: <3FD50CD6.3070808@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> VIA has publicly posted the docs for the 'xstore' and 'xcrypt' 
> instructions in their processors:
>
>     http://www.via.com.tw/en/viac3/c3.jsp
> ...
> They have also supported open source by providing docs and 
> occasionally hardware to myself, Dave Jones, Alan, and others.  So, 
> while it might appear this is a shameless plug :) I just really like 
> the technology, and am never shy about promoting good hardware 
> designs, and vendors that work with the open source community.

Same here, this crypto stuff rocks!

I posted a document and some sources for using the high throughput
entropy source on linux (2.4.23 and 2.4.6test9) here:

    http://peertech.org/hardware/viarng/

The stock hw_random.c needs a few tweaks to support 8 byte xstore,
and I wrote a new userspace entropy daemon to support low latency,
high volume throughput.  I should clean the code up so it is usable...

Best regards,

