Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVLLHaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVLLHaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLLHaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:30:24 -0500
Received: from stinky.trash.net ([213.144.137.162]:13990 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750852AbVLLHaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:30:23 -0500
Message-ID: <439D2704.9090601@trash.net>
Date: Mon, 12 Dec 2005 08:30:12 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Netfilter Core Team <coreteam@netfilter.org>
Subject: Re: [netfilter-core] [PATCH] Decrease number of pointer derefs in
 nf_conntrack_core.c
References: <200512082336.19695.jesper.juhl@gmail.com>
In-Reply-To: <200512082336.19695.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Here's a small patch to decrease the number of pointer derefs in
> net/netfilter/nf_conntrack_core.c
> 
> Benefits of the patch:
>  - Fewer pointer dereferences should make the code slightly faster.
>  - Size of generated code is smaller
>  - improved readability
> 
> Please consider applying.

I've added both patches to my 2.6.16 queue, thanks Jesper.
