Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbUK3MJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUK3MJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUK3MJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:09:33 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:8093 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262044AbUK3MJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:09:32 -0500
To: Arjan van de Ven <arjan@infradead.org>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Tue, 30 Nov 2004 10:04:46 +0100."
             <1101805486.2640.37.camel@laptop.fenrus.org> 
Date: Tue, 30 Nov 2004 12:09:18 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CZ6op-0005QS-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2004-11-30 at 08:56 +0000, Ian Pratt wrote:
> 
> > In the Xen case, we actually need to use io_remap_page_range for
> > all /dev/mem accesses, so as to be able to map the BIOS area, DMI
> > tables etc.
> 
> look at the /dev/mem patches in the -mm tree... there might be
> infrastructure there that is useful to you

Thanks for the pointer. Having looked through, it's orthogonal
and can't help us, though doesn't conflict with our patch either
(fuzz 2).

Thanks,
Ian
