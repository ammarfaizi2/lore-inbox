Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUBWDER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUBWDER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:04:17 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:7060 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261773AbUBWDEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:04:14 -0500
Message-ID: <40396DA7.70200@cyberone.com.au>
Date: Mon, 23 Feb 2004 14:04:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au>
In-Reply-To: <40396ACD.7090109@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> Lowmem pagecache vs highmem pagecache should be balanced correctly?
> I think it is with your other patches.
>
> Lowmem pagecache vs slab should be balanced correctly with my patch.
>
> Therefore highmem vs slab will be balanced correctly.
>
> Is that a good proof?
>
>

Well no, because you can construct a similar "proof" for your
patch because I assume balancing between zones is a two way
operation :P. Actually, lowmem pressure does not assert highmem
pressure which is the point where your balancing fails.

