Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbTFLB1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbTFLB1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:27:54 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:21508 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264667AbTFLB1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:27:52 -0400
Message-ID: <3EE7DA44.7000909@cyberone.com.au>
Date: Thu, 12 Jun 2003 11:41:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Andrew Morton <akpm@digeo.com>, bos@serpentine.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] as-iosched divide by zero fix
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>	 <1055380257.662.8.camel@localhost> <20030611182249.0f1168e4.akpm@digeo.com> <1055381318.662.30.camel@localhost>
In-Reply-To: <1055381318.662.30.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

>On Wed, 2003-06-11 at 18:22, Andrew Morton wrote:
>
>
>>hrm, OK.  Still not convinced about `batch'.
>>
>
>batch is only zero if {read,write}_batch_expire are zero. Nick, is that
>legal/desirable? Or should we prevent that in the sysfs interface?
>

Yeah it shouldn't really be allowed, but I think everything
will keep working (with this change), even writes.


