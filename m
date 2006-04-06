Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDFWt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDFWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDFWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:49:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:12462 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932190AbWDFWt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:49:58 -0400
Date: Thu, 6 Apr 2006 15:46:43 -0700
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060406224643.GA6278@kroah.com>
References: <20060406222359.GA30037@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406222359.GA30037@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 05:24:00PM -0500, Linas Vepstas wrote:
> +	if(pci_enable_device(pdev)) {

Add a space after "if" and before "(" please.

You do this in a few different places.

thanks,

greg k-h
