Return-Path: <linux-kernel-owner+willy=40w.ods.org-S380527AbUKBHi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S380527AbUKBHi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S380507AbUKBHi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:38:56 -0500
Received: from fmr06.intel.com ([134.134.136.7]:6891 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S380464AbUKBHio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:38:44 -0500
Subject: Re: Fw: Re: 2.6.10-rc1-mm1
From: Len Brown <len.brown@intel.com>
To: James Morris <jmorris@redhat.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@intel.com>
In-Reply-To: <Xine.LNX.4.44.0410280225110.13421-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0410280225110.13421-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1099381097.13834.239.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Nov 2004 02:38:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 02:25, James Morris wrote:
> On Wed, 27 Oct 2004, Bjorn Helgaas wrote:
> 
> > I did find a couple places that unregister the driver even when
> > acpi_bus_register_driver() fails, which could cause this.  But I
> > really doubt that this is the problem, because the only error
> > returns there are for "acpi_disabled" and "!driver".  Patch is
> > attached anyway if you want to try it.
> 
> This looks to have fixed the problem.

James,
I had a similar problem, until I cleaned the tree and re-built from
scratch.  I'm wondering if you do the same if the tree w/o any patches
works for you.

thanks,
-Len


