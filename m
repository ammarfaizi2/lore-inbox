Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTIXMGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 08:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTIXMGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 08:06:20 -0400
Received: from dyn-ctb-203-221-73-21.webone.com.au ([203.221.73.21]:50446 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261263AbTIXMGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 08:06:19 -0400
Message-ID: <3F7188B9.2080209@cyberone.com.au>
Date: Wed, 24 Sep 2003 22:06:17 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] runtime selectable IO schedulers
References: <3F717E62.5020404@cyberone.com.au>
In-Reply-To: <3F717E62.5020404@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

Err, alloc _outside_ spinlock... make that
http://www.kerneltrap.org/~npiggin/elv-select.patch-030924-2

>
> Against test5-mm4. This is commented a bit better than the previous
> version I sent to Al and Jens.
>
> sysfs interface is /sys/block/*/queue/io_scheduler. Valid values are
> as, deadline, noop, cfq. Switching schedulers under disk load works fine
> in my tests. sysfs stuff seems to be working nicely and handles lingering
> userspace references properly.
>
> Review of the kobject / sysfs stuff would be especially helpful. Thanks.
>
>

