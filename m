Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUBZCk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUBZCkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:40:55 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:41709 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261525AbUBZCkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:40:53 -0500
Message-ID: <403D5CB1.50409@cyberone.com.au>
Date: Thu, 26 Feb 2004 13:40:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D5B4C.3020309@matchmail.com>
In-Reply-To: <403D5B4C.3020309@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

>
> OK, I'll give that a try.
>
> Is the attached patch the latest version of your alternative patch 
> instead of shrink_slab-for-all-zones.patch?
>

Yes that looks like it. I am actually starting to like this patch
again now that lowmem is being properly scanned as a result of
highmem scanning.

But it should be functionally very similar to just scanning slab
on highmem pressure like -mm3 does.

