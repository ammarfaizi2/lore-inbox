Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUBRTlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUBRTlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:41:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:28088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267971AbUBRTkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:40:21 -0500
Date: Wed, 18 Feb 2004 11:22:58 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Fix pci_bus_find_capability()
Message-ID: <20040218192258.GA4572@kroah.com>
References: <20040210182803.GH13351@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210182803.GH13351@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 06:28:03PM +0000, Matthew Wilcox wrote:
> 
> Hi Greg.  pci_bus_find_capability() is currently broken.  It checks the
> wrong device's hdr_type for being a cardbus bridge or not.  This patch
> pulls the guts of pci_bus_find_capability() and pci_find_capability()
> into a new function __pci_bus_find_cap() and changes these two functions
> to call it.

Applied, thanks.

greg k-h
