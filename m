Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUJ0T0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUJ0T0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUJ0TYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:24:21 -0400
Received: from mail.dif.dk ([193.138.115.101]:43686 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262591AbUJ0TXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:23:22 -0400
Date: Wed, 27 Oct 2004 21:31:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Would auto setting CONFIG_RTC make sense when building SMP
 kernel?
In-Reply-To: <1098893383.4304.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410272130170.3284@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
 <1098893383.4304.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Alan Cox wrote:

> On Maw, 2004-10-26 at 20:13, Jesper Juhl wrote:
> > Isn't it always desirable to be able to set the clock in an SMP compatible 
> > fashion if the kernel is indeed build for SMP?
> 
> Probably it is best to just move it to CONFIG_EMBEDDED. Without the
> driver the clock binary bitbangs the cmos and that isnt safe non SMP
> either nowdays
> 
Ok, I'll throw together a patch that makes it default to yes and moves it 
to embedded. 

--
Jesper Juhl

