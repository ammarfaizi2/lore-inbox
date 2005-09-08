Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVIHSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVIHSaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIHSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 14:30:00 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:30091 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964917AbVIHS37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 14:29:59 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 12:29:51 -0600
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <1126163937.21723.12.camel@toshiba> <20050908003420.00e49325.akpm@osdl.org>
In-Reply-To: <20050908003420.00e49325.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509081229.51208.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 1:34 am, Andrew Morton wrote:
> Len Brown <len.brown@intel.com> wrote:
> >
> > Hi Linus, please pull from the release branch here:
> > 
> >  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> There are a few bugs which I'd identified as arising from the acpi tree
> while it was in -mm.  Is this patch likely to drag them into mainline?
> 
> They include:
> 
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4977
>             Summary: ACPI 20050708 fails on HP RX2600 platform

I tested 2.6.13 + the acpi-20050902 patch, and it works fine, so
I think this bug can be closed.  I pinged the submitter to do so.
