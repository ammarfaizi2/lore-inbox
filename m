Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTJQQwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTJQQwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:52:41 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:19724 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263531AbTJQQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:52:39 -0400
Date: Fri, 17 Oct 2003 17:52:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Otto Solares <solca@guug.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <20031016210643.GD19795@guug.org>
Message-ID: <Pine.LNX.4.44.0310171751200.966-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Could I2C be ported to kernel I2C api and separated?, so it use would not
> require the fbdev module loaded.

I don't think that can be done. At least not easily.
 
> - PCI IDs list should be in pci_ids.h as every other drivers, reality is
> that adding new IDs to pci_ids.h is not hard so your driver will not be the
> exception to the rule.

I agree here. We do need to watch out for the AGP drivers. Changing PCI 
Id's can break them. I dicovered that recently.


