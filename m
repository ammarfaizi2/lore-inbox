Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271007AbTHLRsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTHLRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:48:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42178 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271007AbTHLRsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:48:13 -0400
Date: Tue, 12 Aug 2003 18:48:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Jones <davej@redhat.com>, Matthew Wilcox <willy@debian.org>,
       Robert Love <rml@tech9.net>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812174810.GD10015@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812173707.GB6919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812173707.GB6919@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 06:37:07PM +0100, Dave Jones wrote:
> Depends. If it's a huuuge struct (see the device ID struct in 2.4's
> agpgart for eg) it becomes much more readable. Whitespace good, clutter bad.

Yup, absolutely.  My point is that struct pci_device_id is really really
common.  If you've ever looked at a Linux PCI driver, you've seen it.
The agp_bridge_info example is specific to this one driver, so it's new
every time you look at it.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
