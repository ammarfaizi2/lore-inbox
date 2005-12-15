Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVLOOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLOOop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVLOOoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:44:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20491 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbVLOOoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:44:25 -0500
Date: Thu, 15 Dec 2005 14:44:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] IRQ type flags
Message-ID: <20051215144419.GC6211@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <20051212114759.GA10243@flint.arm.linux.org.uk> <192FCF8D-4C27-44DF-9EEA-612AAC427164@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192FCF8D-4C27-44DF-9EEA-612AAC427164@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 08:49:50AM -0600, Kumar Gala wrote:
> >+ * These correspond with the SA_TRIGGER_* defines, and therefore the
> >+ * IRQRESOURCE_IRQ_* defines.
> 
> comment nit.  Should be IORESOURCE_IRQ_* not IRQRESOURCE_IRQ_*

Added, thanks.

> >+/*
> >+ * As above, these correspond to the IORESOURCE_IRQ_* defines in
> >+ * linux/ioport.h to select the interrupt line behaviour.  When
> >+ * requesting an interrupt without specifying a SA_TRIGGER, the
> >+ * setting should be assumed to be "as already configured", which
> >+ * may be as per machine or firmware initialisation.
> >+ */
> 
> Do you mind expand the comment to convey that LOW/HIGH are related to  
> level sensitive interrupts and FALLING/RISING are for edge.  This is  
> different naming that I'm used to with PowerPC and it can get a  
> little confusing.

Also added.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
