Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWFKAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWFKAVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 20:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWFKAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 20:21:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60603 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932522AbWFKAVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 20:21:12 -0400
Date: Sun, 11 Jun 2006 02:21:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Michael Tokarev <mjt@tls.msk.ru>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <448AF226.7060003@tls.msk.ru>
Message-ID: <Pine.LNX.4.64.0606110140000.32445@scrub.home>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home>
 <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home>
 <e6cgjv$b8t$1@terminus.zytor.com> <4489C83F.40307@tls.msk.ru>
 <Pine.LNX.4.64.0606100316400.17704@scrub.home> <448AF226.7060003@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Jun 2006, Michael Tokarev wrote:

> >> But I see a reason for kinit *now*, in its current form - it's
> >> compatibility.  Later on, maybe the whole stuff can be removed entirely,
> >> to rely on external tools for booting.
> > 
> > The compatibility code is already in the kernel, just don't call it if 
> 
> Isn't kinit/klibc intended to *replace* that whole code in the kernel?

Well, that's the basic idea, but slowly I'm wondering whether anyone has 
really figured out how to do this.
Being able to produce small binaries is part of it, but it somehow also 
has to work together with the rest of system, e.g. how can be configured 
(by the user, distribution, ...) or how can it be extended.
We need to know where we are going, otherwise it's hard to know whether 
we're on the right path.

bye, Roman
