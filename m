Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWFJB2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWFJB2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWFJB2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:28:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32947 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030248AbWFJB2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:28:35 -0400
Date: Sat, 10 Jun 2006 03:28:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Michael Tokarev <mjt@tls.msk.ru>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <4489C83F.40307@tls.msk.ru>
Message-ID: <Pine.LNX.4.64.0606100316400.17704@scrub.home>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home>
 <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home>
 <e6cgjv$b8t$1@terminus.zytor.com> <4489C83F.40307@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Jun 2006, Michael Tokarev wrote:

> But I see a reason for kinit *now*, in its current form - it's
> compatibility.  Later on, maybe the whole stuff can be removed entirely,
> to rely on external tools for booting.

The compatibility code is already in the kernel, just don't call it if 
e.g. there's a /kinit in initramfs. We can add the hooks to the kernel to 
pull whatever you want into the initramfs and with time we can remove 
the old code.
Why create new (temporary?) compatibility code, if the current code is 
working just fine?

bye, Roman
