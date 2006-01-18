Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWARWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWARWJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWARWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:09:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2747 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932547AbWARWJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:09:18 -0500
Date: Wed, 18 Jan 2006 23:08:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Message-ID: <20060118220859.GE1580@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy> <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy> <20060118214709.GA12010@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118214709.GA12010@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 18-01-06 21:47:09, Matthew Garrett wrote:
> On Wed, Jan 18, 2006 at 01:06:09PM -0800, Kristen Accardi wrote:
> 
> > Hum, I don't think so (but maybe someone else knows for sure), I thought
> > that driver was specifically for a certain kind of IBM server, not an
> > IBM laptop.  It looks like from this output that the acpiphp is not
> > recognizing any hotplug capable devices on your laptop.  I believe that
> > this is defined by acpiphp as a slot which is "ejectable", meaning
> > contains an ACPI method called _EJ0.  
> 
> To the best of my knowledge, the X-series docking station doesn't 
> contain any PCI devices. It's an extension of the IDE bus plus some 
> broken out serial, parallel, USB and so on. I'd expect driver support 
> for it to just require supporting the dock object and calling its eject 
> routine when the user hits the eject button.

My docking station (there are two different versions of them,
"regular" and "port extender") certainly contains PCI device. I
installed hp100 network card into it :-).

							Pavel

-- 
Thanks, Sharp!
