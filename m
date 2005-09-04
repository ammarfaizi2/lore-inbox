Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVIDUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVIDUNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVIDUNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:13:12 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37285 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbVIDUNL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:13:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0c247lNNoesGiUUmFIX0UdGeg2t6+AM9t7g8GNTaXggxJZAMaIDkeJfkkrDv12JErTxUGGYrLS9eHBv1O0i6l3UkWHEW2JIqGFboGlFPCmAZnzG8+V9G+nwl8PVUBT6T25nuh1bb5cNWICA/djYF4S7mGfvUmHKwa9aXvPwaL4=
Message-ID: <6880bed305090413132c37fed3@mail.gmail.com>
Date: Sun, 4 Sep 2005 22:13:10 +0200
From: Bas Westerbaan <bas.westerbaan@gmail.com>
Reply-To: bas.westerbaan@gmail.com
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Paul Misner <paul@misner.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050904193350.GA3741@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
	 <200509041549.17512.vda@ilport.com.ua>
	 <200509041144.13145.paul@misner.org>
	 <84144f02050904100721d3844d@mail.gmail.com>
	 <6880bed305090410127f82a59f@mail.gmail.com>
	 <20050904193350.GA3741@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Though 4K stacks are used a lot, they probably aren't used on all
> > configurations yet. Other situations may arise where 8K stacks may be
> > preferred. It is too early to kill 8K stacks imho.
> 
> Please name situations where 8K stacks may be preferred that do not
> involve binary-only modules.

I meant that there could be situations, which have not yet been found,
where it could be preferred to use 8K stacks instead of 4K. When you
switch from having 8K stacks as default to 4K stacks without
possibility for 8K stacks you'd possibly encounter these yet to be
found situations.

When on the other hand the 4K stacks are set as default, leaving the
option in, instead of removing it, these possible situations, when
found, could be resolved (temporarilly) by switching back to 8K
stacks.

After a while having 4K stacks as default would be a better time to
decide whether to remove the option or not instead of now.

-- 
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
