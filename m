Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUBDImR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUBDImR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:42:17 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:20405 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265981AbUBDImQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:42:16 -0500
Message-ID: <4020B05E.3080909@cyberone.com.au>
Date: Wed, 04 Feb 2004 19:42:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More VM benchmarks
References: <40205908.4080600@cyberone.com.au> <40207B67.7040407@cyberone.com.au>
In-Reply-To: <40207B67.7040407@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Nick Piggin wrote:
>
>> http://www.kerneltrap.org/~npiggin/vm/5/
>>


Sorry to keep replying to myself. I've done some runs
with my IO scheduler regression tests and these patches
don't make a significant difference one way or the other
although the results with the patches are generally a
bit better.

Tested OraSim pgbench nickbench tiobench and the read/ls
kernel tree during a streaming read/write. 256MB RAM
this time.

