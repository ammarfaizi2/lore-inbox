Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbUK0Bv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUK0Bv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbUK0BrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263030AbUKZTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:29 -0500
To: linux-kernel@vger.kernel.org, akpm@osdl.org
cc: Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: Xen VMM patch set - take 2 
In-reply-to: Your message of "Fri, 19 Nov 2004 23:16:33 GMT."
             <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> 
Date: Thu, 25 Nov 2004 15:46:55 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CXLph-0000XC-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After an initial flourish of comments which I believe we've
managed to address, it's all gone very quiet.

Is that stunned silence or universal agreement? ;-)

Thanks,
Ian

http://xen.sf.net

> OK folks, this is my second attempt to post the arch xen patches,
> this time against 2.6.10-rc2.
> 
> We need 6 core patches and a bug fix:
> 
>  1. add ptep_establish_new to make va available
>  2. return code for arch_free_page
>  3. runtime disable of VT console
>  4. /dev/mem io_remap_page_range for CONFIG_XEN
>  5. split free_irq into teardown_irq
>  6. alloc_skb_from_cache
> 
> Bug fix:
>  7. handle fragemented skbs correctly in icmp_filter
> 
> The actual new architecture, arch xen, is too big to post to the list,
> so here's a link:
>  http://www.cl.cam.ac.uk/netos/xen/downloads/arch-xen.patch
> 
> Likewise for the virtual block, network, and console drivers:
>  http://www.cl.cam.ac.uk/netos/xen/downloads/drivers-xen.patch
> 
> Applying the above 9 patches should give you everything you need to
> build full-featured arch xen kernels.
> 
> Arch xen will be maintained by myself, Keir Fraser, Christian Limpach
> and Steve hand. 
> 
> Cheers,
> Ian
> 

