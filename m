Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWBGIoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWBGIoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWBGIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:44:20 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8156
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965011AbWBGIoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:44:19 -0500
Date: Tue, 07 Feb 2006 00:44:15 -0800 (PST)
Message-Id: <20060207.004415.17761960.davem@davemloft.net>
To: torvalds@osdl.org
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0602061656560.3854@g5.osdl.org>
References: <20060206.160140.59716704.davem@davemloft.net>
	<20060207112713.7cd0a61c.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0602061656560.3854@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 6 Feb 2006 17:15:23 -0800 (PST)

> Oh f*ck, why do people do ugly code like this?
>
> That's just about the nastiest thing I've ever seen.

I totally agree.
> 
> However, what I suspect David was actually suggesting was to just have 
> some trivial for just the compat functions. You can generate them 
> automatically based on 
>  - function name
>  - signedness/unsignedness of each argument
> with some preprocessor hackery.
> 
> So each architecture could have the following #defines:

Exactly.
