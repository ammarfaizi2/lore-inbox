Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269948AbUJSWFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269948AbUJSWFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbUJSVsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:48:01 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:2239 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268255AbUJSVdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:33:41 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=filFANK35VZCqAIOu4feR1P/9k7KNLsxo283DPX7IBj3RBExCofD+yEHitFI7hmdZBHgu5oOQNr6/I9Uu+/SUgHUVL5HNvgxQpOVsa7nA5kSouTdkDH4t01RZglmW5fRi6uEGR+h4BjWEBUnS6ZU2aPQuJwZ5Fm3FMP5BgdPtIU
Message-ID: <4d8e3fd304101914332979f86a@mail.gmail.com>
Date: Tue, 19 Oct 2004 23:33:40 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BK kernel workflow
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
       torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <41753B99.5090003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41752E53.8060103@pobox.com>
	 <20041019153126.GG18939@work.bitmover.com>
	 <41753B99.5090003@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 12:06:49 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> Although tangential to the problem, I thought LKML and BitMover (and
> maybe Andrew or Linus as well) might be interested in a general
> description of my workflow.
> 
> For net drivers in the Linux kernel, there exists two patch queues,
> net-drivers-2.6 and netdev-2.6 (and corresponding 2.4 versions).
> net-drivers-2.6 could be described as the "upstream immediately" or "for
> Linus" queue, and netdev-2.6 could be described as the "testing" queue.

So you have two bk trees, 
- patches good for mainstream
- patches good for -mm tree

It would be cool if all the maintainers could adopt your working method,
Andrew is already automatically pulling from a bunch of trees, why not
having Linusdoing the same too?

Something like:
linux-2.6.XX is released
- Linus pull from all the "patches good for mainstream" bk trees and
from the equivalent Andrew tree (that doesn't exist at the moment)
- Linus release the first -pre release
- Linus gets other patches according to the "old" method
- Linus releases the -pre/-rc

Is it just a stupid idea ?

-- 
Paolo
