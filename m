Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVBAAfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVBAAfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBAAdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:33:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:60565 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261486AbVBAAZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:25:07 -0500
Date: Mon, 31 Jan 2005 16:15:04 -0800
From: Greg KH <greg@kroah.com>
To: brking@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Add Citrine quirk
Message-ID: <20050201001503.GB7498@kroah.com>
References: <200501281453.j0SErn7w002778@d03av02.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281453.j0SErn7w002778@d03av02.boulder.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:53:47AM -0600, brking@us.ibm.com wrote:
> 
> The IBM Citrine chipset has a feature that if PCI config register
> 0xA0 is read while DMAs are being performed to it, there is the possiblity
> that the parity will be wrong on the PCI bus, causing a parity error and
> a master abort. On this chipset, this register is simply a debug register
> for the chip developers and the registers after it are not defined.
> Patch sets cfg_size to 0xA0 to prevent this problem from being seen.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>

Applied, thanks.

greg k-h
