Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTFLRgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFLRej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:34:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57831 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264929AbTFLRe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:34:26 -0400
Date: Thu, 12 Jun 2003 18:48:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate binfmt choices in Kconfig
Message-ID: <20030612174811.GP30843@parcelfarce.linux.theplanet.co.uk>
References: <20030612172011.GO30843@parcelfarce.linux.theplanet.co.uk> <20030612173541.GG828@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612173541.GG828@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:35:41AM -0700, Tom Rini wrote:
> Just a nit:
> > +config BINFMT_ZFLAT
> > +	bool "  Enable ZFLAT support"
> 
> Shouldn't that just be:
> bool "Enable ZFLAT support"
> as the config bits take care of indentation now?

Yep, thanks, updated patch uploaded.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
