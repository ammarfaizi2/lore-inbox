Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267768AbTAXPu7>; Fri, 24 Jan 2003 10:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTAXPu7>; Fri, 24 Jan 2003 10:50:59 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:8964 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267768AbTAXPu7>;
	Fri, 24 Jan 2003 10:50:59 -0500
Message-ID: <3E31630E.7070601@cyberone.com.au>
Date: Sat, 25 Jan 2003 03:00:14 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Andrew Morton <akpm@digeo.com>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
References: <20030123195044.47c51d39.akpm@digeo.com>	<946253340.1043406208@[192.168.100.5]>	<20030124031632.7e28055f.akpm@digeo.com> <15921.11824.472374.112916@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Andrew Morton writes:
>
>[...]
>
> > 
> > In this very common scenario, the only way we'll ever get "lumps" of reads is
> > if some other processes come in and happen to want to read nearby sectors. 
>
>Or if you have read-ahead for meta-data, which is quite useful. Isn't
>read ahead targeting the same problem as this anticipatory scheduling?
>
Finesse vs brute force. A bit of readahead is good.

