Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVJYV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVJYV7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJYV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:59:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750892AbVJYV7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:59:20 -0400
Date: Tue, 25 Oct 2005 14:59:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grant Coady <gcoady@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <435EA6C1.6070008@gmail.com>
Message-ID: <Pine.LNX.4.64.0510251455460.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org> <435EA6C1.6070008@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Oct 2005, Grant Coady wrote:
>
> four :o)

Thanks.

Of your four, only "tosh" uses the device resources that we onyl now 
parse, and even that one only does it for a legacy region.

But so far at least nobody has reported a machine where it would do the 
wrong thing, so we're doing pretty well.

And I guess it would have been surprising if there were a lot of machines 
around with PCI resources we didn't know about - the reason it took so 
long for us to notice was exactly the fact that it's pretty rare that 
anybody uses it outside of the legacy region.

		Linus
