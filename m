Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbTL1KBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 05:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbTL1KBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 05:01:10 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:2019 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S265051AbTL1KBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 05:01:08 -0500
Date: Sat, 27 Dec 2003 19:38:30 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: panic in bttv_risc_planar
In-Reply-To: <3320000.1072499450@[10.10.2.4]>
Message-ID: <Pine.LNX.4.53.0312271935150.573@grinch.ro>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro> <2850000.1072477728@[10.10.2.4]>
 <Pine.LNX.4.53.0312270235570.7966@grinch.ro> <3320000.1072499450@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Martin J. Bligh wrote:

> Dec 26 17:59:08 grinch kernel: Unable to handle kernel paging request at virtual address c4bea00c
> Dec 26 17:59:08 grinch kernel:  printing eip:
> Dec 26 17:59:08 grinch kernel: c0333f60
> ...
> and yet ...
> ...
> > 0xc0333f63 <bttv_risc_planar+579>:	mov    %eax,(%ecx)
> > 0xc0333f65 <bttv_risc_planar+581>:	add    %edx,0x5c(%esp,1)
>
> Mmm. you *sure* nothing else changed? You didn't take out -O2 when you
> put in -g or change the config file at all or anything?
>

yes (almost)
the *only* thing i did was to select
 [*]   Compile the kernel with debug info
in menuconfig
I have no ideea what gcc options will change if i select this option in
kernel config.

> M.
>
