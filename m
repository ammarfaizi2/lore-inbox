Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263198AbVCKFYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbVCKFYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVCKFYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:24:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:5029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263198AbVCKFXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:23:15 -0500
Date: Thu, 10 Mar 2005 21:23:02 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI Express Advanced Error Reporting Driver
Message-ID: <20050311052302.GB27775@kroah.com>
References: <200503102304.j2AN4INc018805@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503102304.j2AN4INc018805@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 03:04:18PM -0800, long wrote:
> PCI Express error signaling can occur on the PCI Express link itself
> or on behalf of transactions initiated on the link. PCI Express
> defines the Advanced Error Reporting capability, which is implemented 
> with a PCI Express advanced error reporting extended capability
> structure, to provide more robust error reporting. With the Advanced
> Error Reporting capability a PCI Express component, which detects an
> error, can send an error message to the Root Port associated with
> its hierarchy.  

<snip>

This patch was too big for lkml, and should also be sent to the
linux-pci list.  Care to split it up and resend it?

Also, how does this tie into the recent discussion about pci error
recovery?

thanks,

greg k-h
