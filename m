Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVIFW6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVIFW6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIFW6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:58:09 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:40709 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751100AbVIFW6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:58:07 -0400
Date: Tue, 6 Sep 2005 18:57:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [patch 2.6.13 2/2] 3c59x: add option for using memory-mapped PCI I/O resources
Message-ID: <20050906225744.GB26003@tuxdriver.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jgarzik@pobox.com
References: <20050906204147.GC20145@tuxdriver.com> <20050906204400.GD20145@tuxdriver.com> <20050906205429.GA19319@infradead.org> <20050906140414.40b65253.akpm@osdl.org> <20050906220922.GA26003@tuxdriver.com> <20050906151546.4d5ed4db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906151546.4d5ed4db.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 03:15:46PM -0700, Andrew Morton wrote:
> "John W. Linville" <linville@tuxdriver.com> wrote:
> >
> > I fully intend to have have a flag in the private data set based on
> >  the PCI ID when I accumulate some data on which devices support this
> >  and which don't.  So far I've only got a short list...  Do you think
> >  such a flag should be based on which ones work, or which ones break?
> 
> The ones which are known to work.
> 
> Bear in mind that this is an old, messy and relatively stable driver which
> handles a huge number of different NICs.   Caution is the rule here.

I definitely agree.  That is another part of why I defaulted to "use_mmio=0".

I'll post PCI ID based patches as I determine supported cards.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
