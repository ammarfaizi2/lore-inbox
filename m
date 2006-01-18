Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWARVsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWARVsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWARVsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:48:05 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:1678 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161012AbWARVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:48:02 -0500
Date: Wed, 18 Jan 2006 21:47:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Message-ID: <20060118214709.GA12010@srcf.ucam.org>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy> <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137618370.31839.12.camel@whizzy>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 01:06:09PM -0800, Kristen Accardi wrote:

> Hum, I don't think so (but maybe someone else knows for sure), I thought
> that driver was specifically for a certain kind of IBM server, not an
> IBM laptop.  It looks like from this output that the acpiphp is not
> recognizing any hotplug capable devices on your laptop.  I believe that
> this is defined by acpiphp as a slot which is "ejectable", meaning
> contains an ACPI method called _EJ0.  

To the best of my knowledge, the X-series docking station doesn't 
contain any PCI devices. It's an extension of the IDE bus plus some 
broken out serial, parallel, USB and so on. I'd expect driver support 
for it to just require supporting the dock object and calling its eject 
routine when the user hits the eject button.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
