Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUDMUJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbUDMUJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 16:09:23 -0400
Received: from palrel10.hp.com ([156.153.255.245]:28901 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263722AbUDMUJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 16:09:20 -0400
Date: Tue, 13 Apr 2004 13:09:08 -0700
From: Grant Grundler <iod00d@hp.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] PCI MSI Kconfig consolidation
Message-ID: <20040413200908.GF6559@cup.hp.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502404058232@orsmsx404.jf.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 12:16:10PM -0700, Nguyen, Tom L wrote:
> It looks good; however, it may create a confusion on ia64 because ia64 
> is already vector-based indexing. 

Ok. Can you submit another patch to cleanup the wording so it's clear
this option only changes ia32 IRQ support?

The key feature is MSI support (which I think depends on vector-based
indexing) which is arch independent.

grant
