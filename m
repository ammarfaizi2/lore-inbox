Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDTHhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDTHhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 03:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDTHhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 03:37:20 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:8872 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750742AbWDTHhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 03:37:18 -0400
Date: Thu, 20 Apr 2006 08:37:13 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420073713.GA25735@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 01:45:27PM +0800, Yu, Luming wrote:

> Do you plan to port the whole acpi event interface into input layer?
> If so,  keycode is NOT a right way.

Not really, though it would be one possibility. However, the input layer 
doesn't really provide the flexibility needed for certain events. I'm 
not sure what the right answer is for other events, but I'm pretty sure 
the button driver maps onto the input layer sensibly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
