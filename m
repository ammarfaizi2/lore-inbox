Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTJSAvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 20:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJSAvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 20:51:52 -0400
Received: from dyn-ctb-210-9-243-127.webone.com.au ([210.9.243.127]:14340 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261946AbTJSAvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 20:51:51 -0400
Message-ID: <3F91E01C.4090507@cyberone.com.au>
Date: Sun, 19 Oct 2003 10:51:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: linux-kernel@vger.kernel.org, rob@landley.net
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
References: <200310180018.21818.rob@landley.net>	 <3F90CFE5.5000801@cyberone.com.au> <1066477155.5606.34.camel@sonja>
In-Reply-To: <1066477155.5606.34.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Egger wrote:

>Am Sam, den 18.10.2003 schrieb Nick Piggin um 07:30:
>
>
>>This came up on the list a while back. IIRC the conclusion was that
>>runtime memory usage and speed, and not so significant compression
>>improvement over gzip.
>>
>
>I quick test with a PowerPC kernel and the normal vmlinux image reveals
>that this is nonsense. 
>
>-rwxr-xr-x    1 root     root      2766490 2003-09-27 22:29 vmlinux
>-rwxr-xr-x    1 root     root      1149410 2003-09-27 22:29 vmlinux.gz
>-rwxr-xr-x    1 root     root      1062999 2003-09-27 22:29 vmlinux.bz2
>
>This is a 86411 bytes or 8.1% reduction, seems significant to me...
>

Sure, it might be worth it in some cases. I didn't mean improvement
wasn't measurable at all.


