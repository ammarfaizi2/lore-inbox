Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWCEXMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWCEXMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWCEXMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:12:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751297AbWCEXM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:12:29 -0500
Date: Sun, 5 Mar 2006 18:11:18 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ACPI should depend on, not select PCI
Message-ID: <20060305231118.GB22019@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	len.brown@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060305222136.GD20287@stusta.de> <20060305142554.1d0ee460.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305142554.1d0ee460.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 02:25:54PM -0800, Andrew Morton wrote:
 > Adrian Bunk <bunk@stusta.de> wrote:
 > >
 > > ACPI should depend on, not select PCI.
 > > 
 > 
 > It's surprising that there's any such linkage, actually.  Is it
 > impossible for a non-PCI system to have ACPI?

When ACPI was concieved (~1999 according to the spec I have handy)
ISA-only PCs were somewhat scarce.  It's probably safe to say anything
that supports ACPI has PCI  (For x86[64] at least, I don't know about ia64)

The spec mentions as a minimum requirement for OSPM/ACPI systems
amongst other things..

"A _PRT method for all root PCI bridges"

which pretty much sounds like it's at dependant on PCI (or a later
evolved standard like PCIE) hardware being present.

		Dave

-- 
http://www.codemonkey.org.uk
