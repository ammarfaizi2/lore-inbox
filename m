Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVHYJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVHYJQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVHYJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:16:09 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:9239 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S964893AbVHYJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:16:08 -0400
Date: Wed, 24 Aug 2005 23:49:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Kumar Gala <galak@freescale.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 05/15] ia64: remove use of asm/segment.h
Message-ID: <20050824224929.GB2714@linux-mips.org>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <Pine.LNX.4.61.0508241152380.23956@nylon.am.freescale.net> <200508241409.55570.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508241409.55570.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 02:09:55PM -0600, Bjorn Helgaas wrote:

> On Wednesday 24 August 2005 10:53 am, Kumar Gala wrote:
> > Removed IA64 architecture specific users of asm/segment.h and
> > asm-ia64/segment.h itself
> 
> I posted a similar patch a month ago, but I only removed the
> arch/ia64 includes of asm/segment.h.
> 
> There are still a few drivers that include asm/segment.h, so
> I don't think we should remove asm/segment.h itself just yet.

<asm/segment.h> was replaced by <asm/uaccess.h> in 2.1.4 and we still have
references ...

  Ralf
