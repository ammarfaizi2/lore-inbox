Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271811AbTHHThY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271812AbTHHTfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:35:22 -0400
Received: from adsl-63-192-214-25.dsl.snfc21.pacbell.net ([63.192.214.25]:61535
	"EHLO mail.kloo.net") by vger.kernel.org with ESMTP id S271811AbTHHTfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:35:05 -0400
Date: Fri, 8 Aug 2003 12:24:09 -0700 (PDT)
From: <tm_gccmail@mail.kloo.net>
To: Bernardo Innocenti <bernie@develer.com>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Big kernel size increase with gcc 3.4
In-Reply-To: <3F330D46.8020508@develer.com>
Message-ID: <Pine.LNX.4.21.0308081223260.29338-100000@mail.kloo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Bernardo Innocenti wrote:

> Hello,
> 
> these figures speak for themselves:
> 
>    text    data     bss     dec     hex filename
>  833352   47200   78884  959436   ea3cc linux-2.6.x/vmlinux_gcc331
>  877420   53212   78884 1009516   f676c linux-2.6.x/vmlinux_gcc34
> 
> 
>  - target is linux-2.6.0-test2-uc0 for m68knommu (full config
>    available on request);
> 
>  - same optimization flags: -m5307 -O2 -fno-strict-aliasing
>       -fno-common -fno-builtin -fomit-frame-pointer

Could you add -fno-reorder-blocks and report the result?

Toshi


