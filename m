Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVI0API@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVI0API (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVI0API
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:15:08 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:64521 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964773AbVI0APG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:15:06 -0400
Date: Mon, 26 Sep 2005 20:14:29 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Grant Grundler <iod00d@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, "Mallick, Asit K" <asit.k.mallick@intel.com>,
       gregkh@suse.de
Subject: Re: [patch 2.6.14-rc2 0/5] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050927001427.GC5640@tuxdriver.com>
Mail-Followup-To: Grant Grundler <iod00d@hp.com>,
	"Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	ak@suse.de, "Mallick, Asit K" <asit.k.mallick@intel.com>,
	gregkh@suse.de
References: <B8E391BBE9FE384DAA4C5C003888BE6F047E9021@scsmsx401.amr.corp.intel.com> <20050926224603.GD16113@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926224603.GD16113@esmail.cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 03:46:03PM -0700, Grant Grundler wrote:

> But since swiotlb complies with DMA-API interface and is not related
> to any particular type of bus, I'd rather it go into lib/ instead of
> drivers/pci.

OK...I read Tony's patch post to imply that he is consenting to lib/ as
the location as well.  Tony, please speak-up if that is not the case.

If everyone agrees, I'll re-collect the patches moving everything to
lib/ (plus the one I forgot to repost) and Tony's patch and repost.

So, who is the proper committer for this?  Tony?  Or should I send
them directly to Andrew?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
