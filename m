Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271348AbRHUCxs>; Mon, 20 Aug 2001 22:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271350AbRHUCxi>; Mon, 20 Aug 2001 22:53:38 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:6411 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S271348AbRHUCxX>;
	Mon, 20 Aug 2001 22:53:23 -0400
Message-Id: <200108210253.f7L2rPY47202@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: leroyljr@ccsi.com, linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver 
In-Reply-To: Your message of "Tue, 21 Aug 2001 12:21:43 +1000."
             <18449.998360503@kao2.melbourne.sgi.com> 
Date: Mon, 20 Aug 2001 20:53:25 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You have hit the precise problem that I raised in that thread, you
>cannot rely on timestamps for files that are both generated and
>shipped.

This is a completely different problem having to do with the build for
the aicasm utility missing an explicit dependency regarding the generated,
but certainly not shipped, y.tab.h file.  The grammer recently changed
(a new token was added), so those with stale y.tab.h files were bitten.
Its on my list of things to fix.

--
Justin
