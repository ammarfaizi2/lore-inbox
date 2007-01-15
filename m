Return-Path: <linux-kernel-owner+w=401wt.eu-S1751756AbXAOAai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXAOAai (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXAOAah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:30:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:48996 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbXAOAah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:30:37 -0500
Date: Sun, 14 Jan 2007 16:29:48 -0800
From: Greg KH <greg@kroah.com>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115002948.GB20993@kroah.com>
References: <20070114172421.GA3874@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114172421.GA3874@Ahmed>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 07:24:21PM +0200, Ahmed S. Darwish wrote:
> Substitue intel_rng magic PCI IDs values used in the IDs table
> with the macros defined in pci_ids.h

Why not use the PCI_DEVICE() macro too?  It should make the lines even
smaller.

thanks,

greg k-h
