Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbUDMVaE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUDMVaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:30:04 -0400
Received: from ns.suse.de ([195.135.220.2]:19679 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263757AbUDMVaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:30:00 -0400
Date: Tue, 13 Apr 2004 23:29:37 +0200
From: Andi Kleen <ak@suse.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] PCI MSI Kconfig consolidation
Message-Id: <20040413232937.7d907a71.ak@suse.de>
In-Reply-To: <200404131408.17248.bjorn.helgaas@hp.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
	<200404131408.17248.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 14:08:17 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:


> 
> In fact, I think there's a whole lot more architecture-specific
> knowledge that has leaked across into drivers/pci/msi.[ch].  For

Yes. Far too lot. Even for the relatively small x86<->x86-64 differences.
That was the reason I disabled it for x86-64 initially ....
[hoping that someone with MSI hardware will fix and reenable it]

-Andi
