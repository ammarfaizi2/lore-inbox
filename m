Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269211AbUIHX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbUIHX6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbUIHX5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:57:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:5337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269209AbUIHXyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:54:38 -0400
Date: Wed, 8 Sep 2004 16:50:10 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-bk+] update Documentation/power/pci.txt
Message-ID: <20040908235010.GA8361@kroah.com>
References: <200409081046.24302.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081046.24302.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:46:24AM -0700, David Brownell wrote:
> That document was wrong on some things, misleading on others; this
> fixes some of the issues I noticed.
> 
> However it probably needs to say that drivers for devices that implement
> the PCI PM spec "should" always use pci_set_power_state() to reduce the
> power usage.  If I get ambitions I might submit a patch to the PCI core
> to print a nag message for drivers that don't do that.

Applied, thanks.

greg k-h
