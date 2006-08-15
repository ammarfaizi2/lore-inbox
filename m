Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWHOTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWHOTie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWHOTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:38:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:27311 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030484AbWHOTid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:38:33 -0400
Date: Tue, 15 Aug 2006 12:37:56 -0700
From: Greg KH <gregkh@suse.de>
To: Henne <henne@nachtwindheim.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Change pci_module_init from macro to inline function marked as deprecated
Message-ID: <20060815193756.GA15203@suse.de>
References: <44E18DE2.8020700@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E18DE2.8020700@nachtwindheim.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 11:03:30AM +0200, Henne wrote:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Replaces the pci_module_init()-macro with a inline function,
> which is marked as deprecated.
> This gives a warning at compile time, which may be useful for driver developers who still use
> pci_module_init() on 2.6 drivers.

Have you gotten the network driver authors to buy into this?  Last I
heard, they did not want to change over for a few reasons.

If not, I'm not going to apply this, as it will just cause a zillion
warnings that will not get fixed up.

thanks,

greg k-h
