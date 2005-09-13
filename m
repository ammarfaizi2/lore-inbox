Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbVIMPOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbVIMPOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVIMPOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:14:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932661AbVIMPOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:14:14 -0400
Date: Tue, 13 Sep 2005 08:14:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mathieu Fluhr <mfluhr@nero.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <1126608030.3455.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509130805250.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
 <1126608030.3455.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
>
> DVD burning is broken since 2.6.13-rc1 and I checked this
> morning the 2.6.14-rc1: Same status.
>
> As far as I looked in the source code, it seems to be lots (and lots) of
> changes between these 2 versions, specially regarding block devices
> drivers. But the ChangeLog is so huge that it is quite impossible to
> make a step-by-step upgrade to see _where_ the problem is :-(

Yes, 2.6.12..2.6.13-rc1 was pretty big, However, the IDE driver changes 
aren't that big.

None of your bug-reports seem to say even what driver you're using, 
though, so it's a bit hard to make any judgement at all.

We at a minimum need to know what driver, and see boot messages (both
working and nonworking), and preferably things like "hdparm -I" output 
(again, both working and nonworking) too. Often "lspci -vvx" is useful 
too.

		Linus
