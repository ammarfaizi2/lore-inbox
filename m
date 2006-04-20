Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDTQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDTQzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDTQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:55:22 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:10175 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751127AbWDTQzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:55:21 -0400
Date: Thu, 20 Apr 2006 17:55:15 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, "Yu, Luming" <luming.yu@intel.com>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420165515.GA30415@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com> <20060420164419.GA30317@srcf.ucam.org> <4447BB2B.1060407@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447BB2B.1060407@linux.intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:47:39PM +0400, Alexey Starikovskiy wrote:

> Yes, this is why I mentioned using kevent and dbus before... Could it be 
> the righter answer?

I think it makes sense for atkbd and usb hid power and sleep buttons to 
be treated like all other keys on those keyboard types. As a result, I 
think it makes sense for ACPI keys to behave in the same way. I wrote an 
addon for hal to take input events and put them on the system dbus some 
time ago, so that's already a solved problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
