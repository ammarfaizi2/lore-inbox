Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUAWO30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUAWO30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:29:26 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:5249 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266561AbUAWO3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:29:25 -0500
Message-ID: <40112E29.4060800@cyberone.com.au>
Date: Sat, 24 Jan 2004 01:22:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Evaldo Gardenali <evaldo@gardenali.biz>, linux-kernel@vger.kernel.org
Subject: Re: buggy raid checksumming selection?
References: <40112465.8040801@gardenali.biz> <20040123141352.GA19002@redhat.com>
In-Reply-To: <20040123141352.GA19002@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Jones wrote:

>On Fri, Jan 23, 2004 at 11:40:53AM -0200, Evaldo Gardenali wrote:
>
> > Uhh. correct me if I am wrong, but shouldnt it select the fastest algorithm?
>
>No, if it can choose a function which avoids polluting the cache over
>one that doesn't, it will.  Even if that means slightly less raw throughput
>
>This comes up time after time, maybe we need a printk in that case ?
>

How about removing the entire output? Is it really needed?

