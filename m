Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWB0Wwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWB0Wwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWB0Wwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:52:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932344AbWB0Wwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:52:34 -0500
Date: Mon, 27 Feb 2006 14:51:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: Linux v2.6.16-rc5
Message-Id: <20060227145120.0712eaac.akpm@osdl.org>
In-Reply-To: <4403586C.2020004@keyaccess.nl>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<4403586C.2020004@keyaccess.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
> Linus Torvalds wrote:
> 
> > Have I missed anything? Holler. And please keep reminding about any 
> > regressions since 2.6.15.
> 
> This one isn't in: http://lkml.org/lkml/2006/2/21/7
> 
> Andrew did pick it up -- pnp-bus-type-fix.patch, named as being in the 
> 2.6.16 queue in his 2.6.16-rc4-mm2 announce:
> 
> http://lkml.org/lkml/2006/2/24/66
> 
> so it's probably okay. The other two patches from that same thread 
> already made it into -rc5 though, so thought I'd ping anyway. It does 
> really want to make 2.6.16. Many ISA-PnP drivers are quite severely 
> broken without (it's also a regression against 2.6.15).
> 

Problem is, that patch was just a "here, try this" thing which Adam slung
onto the mailing list - I have no idea whether it was compete or final or
whether he wants it in 2.6.16 or what.  No indication of what problem it's
fixing, nor how, now what risk there is of breaking something else.  It's
just a lonely little diff at present.

