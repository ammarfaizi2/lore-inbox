Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFHNm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFHNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFHNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:42:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:13441 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261244AbVFHNlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:41:15 -0400
Date: Wed, 8 Jun 2005 15:41:09 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       ak@suse.de
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
Message-ID: <20050608134109.GW23831@wotan.suse.de>
References: <20050608063559.GA22869@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608063559.GA22869@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 11:35:59PM -0700, Greg KH wrote:
> Ok, I'm very sorry for wasting people's time on this.  In the end, I
> agree that the MSI code should stay as is.  It's just to complex and
> confusing to enable it always for all devices at this time.  I'll put
> the pci_enable/pci_disable idea on my TODO list to try to help out with
> some of the logic that every-other pci driver seems to have to duplicate
> all the time.  That seems like the best way forward.


I disagree it should stay as it is. Basically you are trading
a bit less complexity in Infiniband now for a lot of code everywhere.

Does not seem like a good tradeoff.

-Andi
