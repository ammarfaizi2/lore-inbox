Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTJQXT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTJQXT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:19:28 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:22020 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261168AbTJQXT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:19:27 -0400
Message-ID: <3F9078F8.6090604@cyberone.com.au>
Date: Sat, 18 Oct 2003 09:19:20 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 with reiser4, mount and /sbin/lilo unkillable in
 D	state.
References: <1066425854.1672.71.camel@spc9.esa.lanl.gov>
In-Reply-To: <1066425854.1672.71.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steven Cole wrote:

>Greetings all,
>
>Here's one I haven't seen before.
>
>After getting an oops with while mounting a freshly made
>reiser4 partition, I recompiled with CONFIG_KALLSYMS and
>then lilo hung up.  Both process 825 and 4436 are unkillable
>with kill -9 in the D state.
>
>The box is still up for now. If I can't get this fixed in the next hour,
>it'll have to wait until Monday.  It's a test box, so that's OK.
>
>Any advice?
>  
>

Get a sysrq T dump if possible.


