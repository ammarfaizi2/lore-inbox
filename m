Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULECrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULECrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULECru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:47:50 -0500
Received: from holomorphy.com ([207.189.100.168]:35527 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261231AbULECrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:47:49 -0500
Date: Sat, 4 Dec 2004 18:47:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041205024713.GM2714@holomorphy.com>
References: <20041130180337.GT4365@dualathlon.random> <E1Cajei-00040t-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cajei-00040t-00@mta1.cl.cam.ac.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 01:16:56PM +0000, Ian Pratt wrote:
>> Only sparc implements io_remap_page_range differently from
>> remap_pte_range and from Wli answer I understand it's probably ok for
>> sparc to use io_remap_page_range outside ram.

On Sat, Dec 04, 2004 at 11:49:32PM +0000, Ian Pratt wrote:
> So, do we think the best /dev/mem patch is to change the call to
> io_remap_page_range, and have a #ifdef for the SPARC case until
> the number of arguments gets unified?

Yes, that effort is not going to be completed in a timely fashion, so
the #ifdef will have to do for now. I'll clean up the #ifdef once I
actually get back to working on it and do the sweep.


-- wli
