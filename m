Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWFGWmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWFGWmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWFGWmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:42:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40861 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932453AbWFGWmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:42:20 -0400
Date: Thu, 8 Jun 2006 00:42:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <e67fok$h25$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.64.0606080036250.17704@scrub.home>
References: <44869397.4000907@tls.msk.ru> <e67fok$h25$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Jun 2006, H. Peter Anvin wrote:

> To be able to *require* it, which means it can't significantly bloat
> the total size of the kernel image.  klibc binaries are *extremely*
> small.  Static kinit is only a few tens of kilobytes, a lot of which
> is zlib.

Every project starts small and has the annoying tendency to grow.
That still doesn't answer, why it has to be distributed with the kernel, 
just install the thing somewhere under /lib and Kbuild can link to it. The 
point is that it contains nothing kernel specific and doesn't has to be 
rebult with every new kernel.

bye, Roman
