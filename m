Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTEUNXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEUNXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:23:39 -0400
Received: from navigator.sw.com.sg ([213.247.162.11]:13054 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP id S262023AbTEUNXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:23:39 -0400
From: Vladimir Serov <vserov@infratel.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3ECB80D8.8030600@infratel.com>
Date: Wed, 21 May 2003 17:36:24 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <15993.60520.439204.267818@charged.uio.no> <3E7ADBFD.4060202@infratel.com> <shsof45nf58.fsf@charged.uio.no> <3E7B0051.8060603@infratel.com> <15995.578.341176.325238@charged.uio.no> <3E7B10DF.5070005@infratel.com> <15995.5996.446164.746224@charged.uio.no> <3E7B1DF9.2090401@infratel.com> <15995.10797.983569.410234@charged.uio.no> <3EC8DA1B.50304@infratel.com> <20030521102923.B17709@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Looking back on stuff which happened a long time ago, there's a
>possibility that there's an ordering issue with set_current_state.
>
>Please note that this is affects _all_ 2.4 architectures.
>  
>
..........................

>The attached patch should fix your problem.  It should be applied to
>2.4.2x.  All architectures which do not provide set_mb() need to be
>fixed.
>
>  
>

Thanks a lot !!! It works !!!

With best regards, Vladimir.
